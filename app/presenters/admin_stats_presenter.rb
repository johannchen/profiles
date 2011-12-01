class AdminStatsPresenter
  extend ActiveSupport::Memoizable

  def sign_ups_by_date(days=30)
    days -= 1
    date = Time.zone.now
    records = Profile.where(['created_at >= ?', Time.now - days.days])
    records_by_date(records, :created_at, date - days.days, date)
  end

  def messages_by_date(days=30)
    days -= 1
    date = Time.zone.now
    records = Message.where(['created_at >= ?', Time.now - days.days])
    records_by_date(records, :created_at, date - days.days, date)
  end

  private

  def records_by_date(records, date_method, start_date, stop_date)
    by_date = records.group_by { |p| p.created_at.strftime('%Y-%m-%d') }
    # fill in gaps
    {}.tap do |counts|
      date = start_date
      while date <= stop_date
        d = date.strftime('%Y-%m-%d')
        counts[Date.parse(d)] = by_date[d] || []
        date += 1.day
      end
    end
  end
end
