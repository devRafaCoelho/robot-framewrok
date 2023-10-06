*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to edit the first name of the logged in user
    [Tags]    success    first_name

    ${data}    Get data    user    update

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    ${user}    Change field value    ${data}    firstName    Jose
    Remove From Dictionary    ${user}    confirmPassword

    Do login    ${data}[user]
    Update user    ${user}    204

Must be able to edit the last name of the logged in user
    [Tags]    success    last_name

    ${data}    Get data    user    update

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    ${user}    Change field value    ${data}    lastName    Batista
    Remove From Dictionary    ${user}    confirmPassword

    Do login    ${data}[user]
    Update user    ${user}    204

Must be able to edit the phone of the logged in user
    [Tags]    success    phone

    ${data}    Get data    user    update

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    ${user}    Change field value    ${data}    phone    +5511999999999
    Remove From Dictionary    ${user}    confirmPassword

    Do login    ${data}[user]
    Update user    ${user}    204

Should not be able to edit logged-in user data for an email already registered
    [Tags]    error    existing_email

    ${data}    Get data    user    update

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Remove user from database    email    ${data}[userDuplicate][email]
    Insert user into database    ${data}[userDuplicate]

    Do login    ${data}[user]

    ${user}    Change field value    ${data}    email    ${data}[userDuplicate][email]
    Remove From Dictionary    ${user}    confirmPassword
    Update user error    ${user}    400    E-mail already registered.

Should not be able to edit logged-in user data for an cpf already registered
    [Tags]    error    existing_cpf

    ${data}    Get data    user    update

    Remove user from database    cpf    ${data}[user][cpf]
    Insert user into database    ${data}[user]

    Remove user from database    cpf    ${data}[userDuplicate][cpf]
    Insert user into database    ${data}[userDuplicate]

    Do login    ${data}[user]

    ${user}    Change field value    ${data}    cpf    ${data}[userDuplicate][cpf]
    Remove From Dictionary    ${user}    confirmPassword
    Update user error    ${user}    400    CPF already registered.

Should not be able to edit logged-in user data for an invalid password
    [Tags]    error    invalid_password
    ${data}    Get data    user    update

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]

    ${user}    Change field value    ${data}    password    senha123
    Remove From Dictionary    ${user}    confirmPassword
    Update user error    ${user}    400    Invalid password.

Required Fields
    [Tags]    error    required

    ${data}    Get data    user    update

    @{required_list}    Set Variable    firstName    lastName    email    password

    @{name_message_list}    Set Variable
    ...    first name
    ...    last name
    ...    e-mail
    ...    password

    FOR    ${element}    IN    @{required_list}
        ${user}    Copy Dictionary    ${data}[user]
        Set To Dictionary    ${user}    ${element}=${EMPTY}
        Remove From Dictionary    ${user}    confirmPassword

        ${index}    Get Index From List    ${required_list}    ${element}
        ${name_message}    Get From List    ${name_message_list}    ${index}

        IF    '${element}' == 'password'
            ${message}    Set Variable    The password is required.
        ELSE
            ${message}    Set Variable    The ${name_message} is required.
        END

        Do login    ${data}[user]
        Update user error    ${user}    400    ${message}
    END
