## Dev Placement Project

  <p align="left">
 <a href="https://codeclimate.com/github/kobiyoyo/DevPlaceAssessment/maintainability"><img src="https://api.codeclimate.com/v1/badges/dcb2b5a50ac176e8c1ed/maintainability" /></a>
 <a href="https://codeclimate.com/github/kobiyoyo/DevPlaceAssessment/test_coverage"><img src="https://api.codeclimate.com/v1/badges/dcb2b5a50ac176e8c1ed/test_coverage" /></a>
  </p>

## Database Schema
  <img src="app/assets/images/screenshot.png" alt="facebook-project">

## How to Use
To setup files and the app run
```
docker-compose run web bundle install
docker-compose run web rails db:create
docker-compose up

```
Run seed data
```
docker-compose run web rails db:seed
```
Login Details
```
Email: admin@admin.com  Password 01234Admin
```
To run test suite
```
docker-compose run web bundle exec rspec 
```
## API Documentation
#### Sign in
     POST  auth/signin
```
     {
      "email":"rilux@gmail.com",
      "password":"123234566"
      
      } 
```

#### Signup
      POST auth/signup
```
      {
        "first_name": "simon",
        "currency_id": 76,
        "last_name": "adama",
        "email": "simon@gmail.com",
        "password": "123234566"
      }
 ```
#### Currency
###### List all currencies
     GET api/v1/currencies
###### Create currency
     POST api/v1/currencies
```
	{
	  "name": "U.S Dollar",
	  "abbreviation": "USD"
	}
```
#### Transaction
###### List all transactions
     GET api/v1/transactions

###### Create transaction
     POST api/v1/transactions
```
	{
	  "transaction_type": "deposit",
	  "description": "phone money i am savings",
	  "amount": 23.21,
	  "user_id": 99,
	  "wallet_id": 70,
	  "currency_id": 80
	}
```
###### Edit transaction
    PATCH api/v1/transactions/24
 ```
	{
	  "confirm": true
	}

 ```
###### Delete transaction
	DELETE api/v1/transactions/25


#### User
###### List all users
     GET api/v1/users

###### Get a user
     GET api/v1/users/1
     
###### Create user
     POST api/v1/users
```
	{
	  "first_name": "simon",
	  "currency_id": 85,
	  "last_name": "adama",
	  "email": "simon@gmail.com",
	  "password": "123234566"
	}
```
###### Edit user
    PATCH api/v1/users/24
 ```
	{
	  "role": "admin",
	  "active": true
	}

 ```
#### Transaction
###### List all wallets
     GET api/v1/wallets

###### Get a wallet
     GET api/v1/wallets/1

###### Create wallet
     POST api/v1/wallets
```
	{
	  "main": false,
	  "user_id": 109,
	  "currency_id": 89
	}
```
###### Edit wallet
    PATCH api/v1/wallets/24
 ```
	{
	  "currency_id": 90
	}

 ```
###### Delete wallet
	DELETE api/v1/wallets/25
















## Architecture
- There are four entities created in this project (wallet, user, currency, transactions)
- The transactions entity handles the increment and decrement of wallet amount/balance,for example the amount to increment is gotten from transactions table,then used to increment wallet amount.
- In order to create a main wallet,when signing up you are to provide a currency to create a wallet,the wallet is created automatically once signup is successful ,main wallet can be identified when the main attribute is true.
- Elite and Noob users can signup through the signup link,while admin could be created through seed data. 

## Backend
- Ruby on Rails - the web framework used to build the api .
- Rspec - testing framework
- PostgreSQL -  the main reason PostgreSQL is used , in a case where there is a migration failure while modifying your database records , the entire modification gets rolled back to where you started instead of crashing like  MySQL.
- RSpec API Doc Generator - for api documentation


## Requirements

#### Noob
- [x] Can only have a wallet in a single currency selected at signup (main).
- [x] All wallet funding in a different currency should be converted to the main currency.
- [x] All wallet withdrawals in a different currency should be converted to the main currency before transactions are approved.
- [x] All wallet funding has to be approved by an administrator.
- [x] Cannot change main currency.

#### Elite
- [x] Can have multiple wallets in different currencies with a main currency selected at signup.
- [x] Funding in a particular currency should update the wallet with that currency or create it.
- [x] Withdrawals in a currency with funds in the wallet of that currency should reduce the wallet balance for that currency.
- [x] Withdrawals in a currency without a wallet balance should be converted to the main currency and withdrawn.
- [x] Cannot change main currency

#### Admin
- [x] Cannot have a wallet.
- [x] Cannot withdraw funds from any wallet.
- [x] Can fund wallets for Noob or Elite users in any currency.
- [x] Can change the main currency of any user.
- [x] Approves wallet funding for Noob users.
- [x] Can promote or demote Noobs or Elite users


#### Other Requirements
- [x] Write concise api documentation for your endpoints
- [ ] Write tests to cover all scenarios that you implement(I couldnt test service objects,due to time constraints)
- [x] Write a docker-compose file to startup your application and start your db


#
