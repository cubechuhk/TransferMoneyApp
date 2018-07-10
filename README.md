# Transfer Money App

A showcase of a money transfer app with dummy JSON API fetch and parse written in objective c. (Objective C/Xcode 9)

The app consists of 3 steps for transfer money:

- Step 1: Select recipent user and Enter valid amount 

- Step 2: Display the info user selected. After user click "Confirm", API will make GET request with parameters through using AFnetworking.(* See Assumptions point 5)The JSON response will be parse using JSONModel and the object is pass to the Result View.
		
- Step 3: Display the transaction result from JSON response


## 3rd Party Library Used
- AFNetworking 3
- JSONModel

## Screenshot
![Step 1 - Input](https://github.com/cubechuhk/TransferMoneyApp/blob/master/screen1.png)
![Step 2 - Confirmation](https://github.com/cubechuhk/TransferMoneyApp/blob/master/screen2.png)
![Step 3 - Completion](https://github.com/cubechuhk/TransferMoneyApp/blob/master/screen3.png)

## Assumptions
- Each user have a unique user id (uid)
- Each user have associated with 1 account for debit or receive money
- Assume single currency support in the app (HKD)
- For the transaction API, it only response static JSON
- Due to static JSON and server limitation, the app uses "GET" for transaction request
- In actual scenario, "POST" is recommended for transaction request (App Support "POST" request in Network Manager)
- In actual scenario, better to use XIB when collbrate with teams (Storyboard is used in this project)

## API Description
The following are the API called from the app :

## ```GET /transaction```

  Transfers money from one account to another. Returns successful transaction.
  
  *Due to static JSON and server limitation, the app uses "GET" instead of "POST" for transaction request
  

| Request |  | 
| -----------| ------ |
| fromUid | Unique UID indicate money transfer| 
| toUid | Unique UID indicate money receiver| 
| amount | Amount of money will be transfer| 

| Response | | 
| -----------| ------ |
| tid | Unique transaction ID for user reference| 
| tstatus | Transaction status code| 
| ttime | Transaction time (Unix Timestamp)| 

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
