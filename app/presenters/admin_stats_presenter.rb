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
    records = Message.includes(:from, :profile).where(['created_at >= ?', Time.now - days.days])
    records_by_date(records, :created_at, date - days.days, date)
  end

  private

  def records_by_date(records, date_method, start_date, stop_date)
    by_date = records.group_by { |p| p[date_method].strftime('%Y-%m-%d') }
    gap_fill(by_date, start_date, stop_date)
  end

  def gap_fill(records, start_date, stop_date)
    {}.tap do |dates|
      date = start_date
      while date <= stop_date
        d = date.strftime('%Y-%m-%d')
        dates[Date.parse(d)] = records[d] || []
        date += 1.day
      end
    end
  end
end
