# Transfer Money App

A showcase of a money transfer app with dummy JSON API fetch and parse written in objective c. (Objective C/Xcode 9)


## 3rd Party Library Used
- AFNetworking 3
- JSONModel

## Screenshot


## Assumptions
- Each user have a unique user id (uid)
- Each user have associated with 1 account for debit or receive money
- For the transaction API, it onlt response static JSON
- Storyboard used in this project, however better to use XIB when collbrate with teams in actual scenario


## API Description
The following are the API called from the app :

## ```POST /transaction```
  Transfers money from one account to another. Returns successful transaction.

  Example request:
  ```
  {
    "fromUid": "imgrl0x94hj8h2om6201",
    "toUid": "vjre4mxohv9ljxy6neyp",
    "amount": 10.0
  }
  ```
  Example response:
  ```
  Status: 200
  {
    "tid":"wf1clo4lhf",
    "tstatus":"001",
    "ttime":"1531125475"
  }
  ```
  Response Transaction Status Code:
  - 001 : Success
  - 002 : Insufficient fund in debit account
  - 003 : Recipent not found
