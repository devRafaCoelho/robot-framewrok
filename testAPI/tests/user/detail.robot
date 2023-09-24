*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to get user data
    [Tags]    success

    ${data}    Get data    user    login

    Do login    ${data}[user]
    Detail user    200
