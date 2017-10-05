# ActiveValidation

[![Gem Version](https://badge.fury.io/rb/active_validation.svg)](http://badge.fury.io/rb/active_validation)
[![Build Status](https://travis-ci.org/drexed/active_validation.svg?branch=master)](https://travis-ci.org/drexed/active_validation)

ActiveValidation is a collection of custom validators that are often required in Rails applications plus shoulda-style RSpec matchers to test the validation rules.

Highly recommended validators:
  * **DateTime:** Validates Timeliness - https://github.com/adzap/validates_timeliness
  * **Existence:** Validates Existence - https://github.com/perfectline/validates_existence
  * **Group:** Group Validations - https://github.com/adzap/grouped_validations
  * **Overlap:** Validates Overlap - https://github.com/robinbortlik/validates_overlap

## Installation

Add this line to your application's Gemfile:

    gem 'active_validation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_validation

## Table of Contents

* [Alpha](#alphavalidator)
* [AlphaNumeric](#alphanumericvalidator)
* [Base64](#base64validator)
* [Boolean](#booleanvalidator)
* [Coordinates](#coordinatesvalidator)
* [Credit Card](#creditcardvalidator)
* [Csv](#csvvalidator)
* [Currency](#currencyvalidator)
* [CUSIP](#cusipvalidator)
* [Email](#emailvalidator)
* [Equality](#equalityvalidator)
* [FileSize](#filesizevalidator)
* [Hex](#hexvalidator)
* [IMEI](#imeivalidator)
* [IP](#ipvalidator)
* [ISBN](#isbnvalidator)
* [ISIN](#isinvalidator)
* [MAC Address](#macaddressvalidator)
* [Name](#namevalidator)
* [Password](#passwordvalidator)
* [Phone](#phonevalidator)
* [SEDOL](#sedolvalidator)
* [Slug](#slugvalidator)
* [SSN](#ssnvalidator)
* [Time Zone](#timezonevalidator)
* [Tracking Number](#trackingnumbervalidator)
* [Type](#typevalidator)
* [URL](#urlvalidator)
* [Username](#usernamevalidator)
* [UUID](#uuidvalidator)

## AlphaValidator

**Ex:** Example or Example Title

**Rules:**
 * Characters: A-Z a-z
 * Must include: A-Z a-z

With an ActiveRecord model:

```ruby
class Book < ActiveRecord::Base
  attr_accessor :title, :name
  validates :title, alpha: true
end
```

Or any ruby class:

```ruby
class Book
  include ActiveModel::Validations
  attr_accessor :title, :name
  validates :title, alpha: true
end
```

Options: :strict, case: [:lower, :upper]

```ruby
validates :title, alpha: { strict: true }
validates :title, alpha: { case: :lower }
validates :title, alpha: { case: :upper, strict: true }
```

RSpec matcher is also available for your convenience:

```ruby
describe Book do
  it { should ensure_valid_alpha_format_of(:title) }
  it { should_not ensure_valid_alpha_format_of(:name) }
end
```

## AlphaNumericValidator

**Ex:** Example1 or Example Title 1

**Rules:**
 * Characters: A-Z a-z 0-9
 * Must include: A-Z a-z 0-9

With an ActiveRecord model:

```ruby
class Book < ActiveRecord::Base
  attr_accessor :title, :name
  validates :title, alpha_numeric: true
end
```

Or any ruby class:

```ruby
class Book
  include ActiveModel::Validations
  attr_accessor :title, :name
  validates :title, alpha_numeric: true
end
```

Options: :strict
Strict: requires not including spaces

```ruby
validates :title, alpha_numeric: { strict: true }
```

RSpec matcher is also available for your convenience:

```ruby
describe Book do
  it { should ensure_valid_alpha_numeric_format_of(:title) }
  it { should_not ensure_valid_alpha_numeric_format_of(:name) }
end
```

## Base64Validator

**Ex:** YW55IGNhcm5hbCBwbGVhcw==

**Rules:**
 * Characters: 0-1 A-Z =

With an ActiveRecord model:

```ruby
class Code < ActiveRecord::Base
  attr_accessor :code, :name
  validates :code, base64: true
end
```

Or any ruby class:

```ruby
class Code
  include ActiveModel::Validations
  attr_accessor :code, :name
  validates :code, base64: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Code do
  it { should ensure_valid_base64_format_of(:code) }
  it { should_not ensure_valid_base64_format_of(:name) }
end
```

## BooleanValidator

**Ex:** true or false or 1 or 0

**Rules:**
 * Characters: 0-1
 * Equality: true or false

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :active, :name
  validates :active, boolean: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :active, :name
  validates :active, boolean: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_boolean_format_of(:active) }
  it { should_not ensure_valid_boolean_format_of(:name) }
end
```

## CoordinateValidator

**Ex:** 178.213 or -34.985

**Rules:**
* Range: latitude (90 to -90), longitude (180 to -180)
* Characters: 0-9

With an ActiveRecord model:

```ruby
# :coor => [78.47, -169.92]
# :lat  => 91.23
# :lon  => 123.85

class Location < ActiveRecord::Base
  attr_accessor :coor, :lat, :lon, :name
  validates :coor, coordinate: true
  validates :lat,  coordinate: { boundary: :latitude }
  validates :lon,  coordinate: { boundary: :longitude }
end
```

Or any ruby class:

```ruby
# :coor => [78.47, -169.92]
# :lat  => 91.23
# :lon  => 123.85

class Location
  include ActiveModel::Validations
  attr_accessor :coor, :lat, :lon, :name
  validates :coor, coordinate: true
  validates :lat,  coordinate: { boundary: :latitude }
  validates :lon,  coordinate: { boundary: :longitude }
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Location do
  it { should ensure_valid_coordinate_format_of(:coor) }
  it { should_not ensure_valid_coordinate_format_of(:name) }
end
```

## CreditCardValidator

**Ex:** 370000000000002

**Rules:**
 * Characters: 0-9 .-
 * Must include: 0-9
 * Range for card digits: 12-19

With an ActiveRecord model:

```ruby
class Invoice < ActiveRecord::Base
  attr_accessor :cc_number, :name
  validates :cc_number, credit_card: true
end
```

Or any ruby class:

```ruby
class Invoice
  include ActiveModel::Validations
  attr_accessor :cc_number, :name
  validates :cc_number, credit_card: true
end
```

Options: :strict, card: [:american_express (:amex), :diners_club, :discover, :jbc, :laser, :maestro, :mastercard, :solo, :unionpay, :visa]
Strict: requires not including spaces

```ruby
validates :cc_number, credit_card: { card: :visa }
validates :cc_number, credit_card: { strict: true }
validates :cc_number, credit_card: { card: :discover, strict: true }
```

RSpec matcher is also available for your convenience:

```ruby
describe Invoice do
  it { should ensure_valid_credit_card_format_of(:cc_number) }
  it { should_not ensure_valid_credit_card_format_of(:name) }
end
```

## CsvValidator

Options: :columns :columns_in, :columns_less_than, :columns_less_than_or_equal_to,
         :columns_greater_than, :columns_greater_than_or_equal_to, :rows, :rows_in, :rows_less_than,
         :rows_less_than_or_equal_to, :rows_greater_than, :rows_greater_than_or_equal_to

With an ActiveRecord model:

```ruby
class Product < ActiveRecord::Base
  attr_accessor :csv, :name
  validates :csv, csv: { columns: 6, rows_less_than: 20 }
end
```

Or any ruby class:

```ruby
class Product
  include ActiveModel::Validations
  attr_accessor :csv, :name
  validates :csv, csv: { columns_less_than: 6, rows: 20 }
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Product do
  it { should ensure_valid_csv_format_of(:csv) }
  it { should_not ensure_valid_csv_format_of(:name) }
end
```

## CurrencyValidator

**Ex:** 123.00 or .1

**Rules:**
 * Characters: 0-9 .
 * Must include: .
 * Range for cents: 1-2

With an ActiveRecord model:

```ruby
class Product < ActiveRecord::Base
  attr_accessor :price, :name
  validates :price, currency: true
end
```

Or any ruby class:

```ruby
class Product
  include ActiveModel::Validations
  attr_accessor :price, :name
  validates :price, currency: true
end
```

Options: :strict
Strict: requires leading number and exactly two decimals, 1.45

```ruby
validates :price, currency: { strict: true }
```

RSpec matcher is also available for your convenience:

```ruby
describe Product do
  it { should ensure_valid_currency_format_of(:price) }
  it { should_not ensure_valid_currency_format_of(:name) }
end
```

## CusipValidator

**Ex:** 125509BG3

**Rules:**
 * Characters: 0-1 A-Z
 * Length: 1-9

With an ActiveRecord model:

```ruby
class Bank < ActiveRecord::Base
  attr_accessor :code, :name
  validates :code, cusip: true
end
```

Or any ruby class:

```ruby
class Bank
  include ActiveModel::Validations
  attr_accessor :code, :name
  validates :code, cusip: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Bank do
  it { should ensure_valid_cusip_format_of(:code) }
  it { should_not ensure_cusip_base64_format_of(:name) }
end
```

## EmailValidator

**Ex:** user@example.com or user+123@example-site.com

**Rules:**
 * Characters in username: a-z 0-9 -.+_
 * Must include: @
 * Characters in domain: a-z 0-9 -
 * Must include extension: .com, .org, .museum

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :email, :name
  validates :email, email: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :email, :name
  validates :email, email: true
end
```

Options: :domains

```ruby
validates :email, email: { domains: 'com' }
validates :email, email: { domains: :com }
validates :email, email: { domains: [:com, 'edu'] }
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_email_format_of(:email) }
  it { should_not ensure_valid_email_format_of(:name) }
end
```

## EqualityValidator

**Operators:**
 * Less than: x < y
 * Less than or equal to: x <= y
 * Greater than: x > y
 * Greater than or equal to: x >= y
 * Equal to: x == y
 * Not equal to: x != y


**Rules:**
 * Equal and not equal to: cannot be nil

With an ActiveRecord model:

```ruby
class Auction < ActiveRecord::Base
  attr_accessor :bid, :price, :product
  validates :bid, equality: { operator: :greater_than_or_equal_to, to: :price }
end
```

Or any ruby class:

```ruby
class Auction
  include ActiveModel::Validations
  attr_accessor :bid, :price, :product
  validates :bid, equality: { operator: :greater_than_or_equal_to, to: :price }
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Auction do
  it { should ensure_equality_of(:bid).to(:price) }
  it { should_not ensure_equality_of(:bid).to(:product) }
end
```

## FileSizeValidator

Options: :in, :less_than, :less_than_or_equal_to, :greater_than, :greater_than_or_equal_to

With an ActiveRecord model:

```ruby
class Product < ActiveRecord::Base
  attr_accessor :file, :name
  validates :file, file_size: { in: 5.megabytes..10.megabytes }
end
```

Or any ruby class:

```ruby
class Product
  include ActiveModel::Validations
  attr_accessor :file, :name
  validates :file, file_size: { in: 5.megabytes..10.megabytes }
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Product do
  it { should ensure_valid_csv_format_of(:file) }
  it { should_not ensure_valid_csv_format_of(:name) }
end
```

## HexValidator

**Ex:** #a9a9a9 or #999 or aaaaaa or AAA

**Rules:**
* Prefix (non-mandatory): #
* Length: 3 or 6
* Characters: A-F a-f 0-9

With an ActiveRecord model:

```ruby
class Profile < ActiveRecord::Base
  attr_accessor :color, :trim
  validates :color, hex: true
end
```

Or any ruby class:

```ruby
class Profile
  include ActiveModel::Validations
  attr_accessor :color, :trim
  validates :color, hex: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Color do
  it { should ensure_valid_hex_format_of(:color) }
  it { should_not ensure_valid_hex_format_of(:trim) }
end
```

## ImeiValidator

**Ex:** 356843052637512 or 35-6843052-637512 or 35.6843052.637512

**Rules:**
* Length: min 14
* Characters: 0-9 -.

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :imei, :name
  validates :imei, imei: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :imei, :name
  validates :imei, imei: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_imei_format_of(:imei) }
  it { should_not ensure_valid_imei_format_of(:name) }
end
```

## IpValidator

**Ex:** 0.0.0.0 or 127.0.0.1 or 167.39.240.31

**Rules:**
* Length: min 7
* Characters: 0-9 .

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :ip, :name
  validates :ip, ip: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :ip, :name
  validates :ip, ip: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_ip_format_of(:ip) }
  it { should_not ensure_valid_ip_format_of(:name) }
end
```

## IsbnValidator

**Ex:** 9519854894 or 0-9722051-1-x or 978 159059 9938

**Rules:**
* Length: 10 or 13
* Characters: 0-9 -|

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :isbn, :name
  validates :isbn, isbn: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :isbn, :name
  validates :isbn, isbn: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_isbn_format_of(:isbn) }
  it { should_not ensure_valid_isbn_format_of(:name) }
end
```

## IsinValidator

**Ex:** US0378331005 or AU0000XVGZA3

**Rules:**
* Length: 12
* Characters: 0-9 A-Z
* Start: valid country code

With an ActiveRecord model:

```ruby
class Trade < ActiveRecord::Base
  attr_accessor :isin, :name
  validates :isin, isin: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :isin, :name
  validates :isin, isin: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_isin_format_of(:isin) }
  it { should_not ensure_valid_isin_format_of(:name) }
end
```

## MacAddressValidator

**Ex:**
    '08:00:2b:01:02:03'
    '08-00-2b-01-02-03'
    '08002b:010203'
    '08002b-010203'
    '0800.2b01.0203'
    '08002b010203'

**Rules:**
* Characters: a-z 0-9 -.:

With an ActiveRecord model:

```ruby
class Device < ActiveRecord::Base
  attr_accessor :mac, :name
  validates :mac, mac_address: true
end
```

Or any ruby class:

```ruby
class Device
  include ActiveModel::Validations
  attr_accessor :mac, :name
  validates :mac, mac_address: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Device do
  it { should ensure_valid_mac_address_format_of }
  it { should_not ensure_valid_mac_address_format_of(:name) }
end
```

## NameValidator

**Ex:** James Brown or Billy Bob Thorton Jr

**Rules:**
* Range: 2 - 5 names
* Characters: a-z -
* Must include: First Last

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :name, :email
  validates :name, name: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :name, :email
  validates :name, name: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_name_format_of(:name) }
  it { should_not ensure_valid_name_format_of(:email) }
end
```

## PasswordValidator

**Ex:** password or password123 or pa!!word

**Rules:**
* Range: 6-18
* Characters: A-Z a-z 0-9 -_!@#$%^&*

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :password, :name
  validates :password, password: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :password, :name
  validates :password, password: true
end
```
Options: :strict
Strict: requires length between 6 and 18, one number, lowercase, upcase letter

```ruby
validates :password, password: { strict: true }
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_password_format_of(:password) }
  it { should_not ensure_valid_password_format_of(:name) }
end
```

## PhoneValidator

**Ex:** 555 333 4444 or (555) 123-4567 or +1 (555) 123 4567 ext-890

**Rules:**
* Characters: a-z 0-9 -()+

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :phone, :name
  validates :phone, phone: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :phone, :name
  validates :phone, phone: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_phone_format_of(:phone) }
  it { should_not ensure_valid_phone_format_of(:name) }
end
```

## SedolValidator

**Ex:** B0WNLY7

**Rules:**
* Characters: A-Z 0-9

With an ActiveRecord model:

```ruby
class Trade < ActiveRecord::Base
  attr_accessor :sedol, :name
  validates :sedol, sedol: true
end
```

Or any ruby class:

```ruby
class Trade
  include ActiveModel::Validations
  attr_accessor :sedol, :name
  validates :sedol, sedol: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe Trade do
  it { should ensure_valid_sedol_format_of(:sedol) }
  it { should_not ensure_valid_sedol_format_of(:name) }
end
```

## SlugValidator

**Ex:** slug1234 or slug-1234

**Rules:**
* Characters: A-Z a-z 0-9 -_

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :slug, :name
  validates :slug, slug: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :slug, :name
  validates :slug, slug: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_slug_format_of(:slug) }
  it { should_not ensure_valid_slug_format_of(:name) }
end
```

## SsnValidator

**Ex:** 333-22-4444 or 333224444

**Rules:**
* Characters: 0-9 -

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :ssn, :name
  validates :ssn, ssn: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :ssn, :name
  validates :ssn, ssn: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_ssn_format_of(:ssn) }
  it { should_not ensure_valid_ssn_format_of(:name) }
end
```

## TimeZoneValidator

**Ex:** 'America/New_York' or 'London'

**Rules:**
* Any valid time zone

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :time_zone, :name
  validates :time_zone, time_zone: true
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :time_zone, :name
  validates :time_zone, time_zone: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_type_format_of(:time_zone) }
  it { should_not ensure_valid_type_format_of(:name) }
end
```

## TrackingNumberValidator

**Ex:** 1Z8V92A70367203024

With an ActiveRecord model:

```ruby
class Package < ActiveRecord::Base
  attr_accessor :tracking_number, :name
  validates :tracking_number, tracking_number: true
end
```

Or any ruby class:

```ruby
class Package
  include ActiveModel::Validations
  attr_accessor :tracking_number, :name
  validates :tracking_number, tracking_number: true
end
```

Options:
  * carrier: :dhl, :fedex, :ontrac, :ups, :usps
  * service: :express, :express_air, :ground, :ground18, :ground96, :smart_post, :usps13, :usps20, :usps91

```ruby
validates :tracking_number, tracking_number: { carrier: :dhl }
validates :tracking_number, tracking_number: { carrier: :fedex, service: :express }
```

RSpec matcher is also available for your convenience:

```ruby
describe Package do
  it { should ensure_valid_tracking_number_format_of(:tracking_number) }
  it { should_not ensure_valid_tracking_number_format_of(:name) }
end
```

## TypeValidator

**Ex:** Boolean or String

**Rules:**
* Any valid ruby class

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :active, :name
  validates :active, type: Boolean
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :active, :name
  validates :active, type: Boolean
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_type_format_of(:active) }
  it { should_not ensure_valid_type_format_of(:name) }
end
```

## UrlValidator

**Ex:** example.com or http://www.example.com

**Rules:**
* Characters in root: a-z 0-9 -.//:
* Characters in domain: a-z 0-9 -
* Must include extension: .co, .org, .museum

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :url, :name
  validates :url, url: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :url, :name
  validates :url, url: true
end
```

Options: :domains, :root, :scheme

```ruby
validates :url, url: { scheme: :http }
validates :url, url: { scheme: [:http, 'https'] }
validates :url, url: { scheme: :http, root: true, domains: :com }
validates :url, url: { root: true }
validates :url, url: { root: true, domains: :com }
validates :url, url: { domains: 'com' }
validates :url, url: { domains: :com }
validates :url, url: { domains: [:com, 'edu'] }
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_url_format_of(:url) }
  it { should_not ensure_valid_url_format_of(:name) }
end
```

## UsernameValidator

**Ex:** username123 or username

**Rules:**
* Range: 2-16
* Characters: a-z 0-9 -_

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :username, :name
  validates :username, username: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :username, :name
  validates :username, username: true
end
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_username_format_of(:username) }
  it { should_not ensure_valid_username_format_of(:name) }
end
```

## UuidValidator

**Ex:** 886313e1-3b8a-5372-9b90-0c9aee199e5d

**Rules:**
* Characters: A-Z a-z 0-9 -

With an ActiveRecord model:

```ruby
class User < ActiveRecord::Base
  attr_accessor :uuid, :name
  validates :uuid, uuid: true
end
```

Or any ruby class:

```ruby
class User
  include ActiveModel::Validations
  attr_accessor :uuid, :name
  validates :uuid, username: true
end
```

Options: :version

```ruby
validates :uuid, uuid: { version: 3 }
```

RSpec matcher is also available for your convenience:

```ruby
describe User do
  it { should ensure_valid_uuid_format_of(:uuid) }
  it { should_not ensure_valid_uuid_format_of(:name) }
end
```

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
