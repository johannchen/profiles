# Church.IO Profiles

**Profiles** is a humble little Rails 3 app meant to provide an online directory for churches and other close-knit communities.

This app was birthed out of [OneBody](https://github.com/seven1m/onebody), a monolithic application built for social networking, among other things. The scope of **Profiles** is much less ambitious, opting only to recreate the search functionality, profile page and related features instead.

**BEWARE:** this app is early ALPHA quality at the moment, so not everything works yet.

## Features

### User-Facing

* Login with Facebook or by Email
* Profile Page
* Custom Profile Themes (partially complete)
* Search Directory
* Send Email (soon)

### Backend

* Runnable on Heroku
* Easy customization via yaml file
* Localized for US English, with other languages on the way
* Clean, Understandable Ruby

## Built With

* [Ruby](http://www.ruby-lang.org)
* [Rails](http://rubyonrails.org)
* [PostgreSQL](http://www.postgresql.org/)
* [Devise](https://github.com/plataformatec/devise)
* [Bootstrap](http://twitter.github.com/bootstrap/)
* [pjax](https://github.com/defunkt/jquery-pjax)

...and many others...

## Development

Instructions below are meant for running the app **locally** (not on a server).

1. Install Ruby 1.9.2 and bundler (`gem install bundler`).
2. Create your database (PostgreSQL recommended).
3. Create a Facebook app for your community [here](https://developers.facebook.com/apps) (choose the website option) and give it the site URL of `http://localhost:3000`.
4. Now run the following commands:

```shell
cd profiles
cp config/settings.yml{.example,}
vim config/settings.yml
cp config/database.yml{.example,}
vim config/database.yml
bundle install
rake db:reset
rails server
```

## Server Deployment

Check out the wonderful [installation instructions](http://church.io/profiles/install.html) on the website.

## Contact

Catch Tim in the #church.io IRC channel on freenode, on Twitter at [@seven1m](https://twitter.com/seven1m), or by email at [tim@timmorgan.org](http://timmorgan.org).

[http://church.io](http://church.io) hosts additional information avout this and other church software projects.

## Copyright & License

Images in `app/assets/images/bg` are licensed freely and distributable, but are copyright various individuals. Please see [info.yml](https://github.com/churchio/profiles/blob/master/app/assets/images/bg/info.yml) for author and license details.

All code and other assets copyright (c) 2011, [Tim Morgan](http://timmorgan.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
