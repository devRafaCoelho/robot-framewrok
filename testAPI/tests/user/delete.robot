*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to delete the logged in user
    [Tags]    success

    ${data}    Get data    user    delete

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]
    Delete user    204
