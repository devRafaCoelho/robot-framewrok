*** Settings ***
Library     ./database/database.py
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Resource    ./env.resource
Resource    ./controllers/UserController.resource


*** Keywords ***
Get data
    [Arguments]    ${fileName}    ${scenario}

    ${data}    Load Json From File    ${EXECDIR}/resources/json/${fileName}.json    encoding=utf-8
    RETURN    ${data}[${scenario}]

Change field value
    [Arguments]    ${data}    ${field_name}    ${field_value}

    ${user}    Copy Dictionary    ${data}[user]
    Set To Dictionary    ${user}    ${field_name}=${field_value}

    RETURN    ${user}

# Reset user from database
#    [Arguments]    ${user}

#    Remove user from database    ${user}[email]
#    Insert user into database    ${user}
