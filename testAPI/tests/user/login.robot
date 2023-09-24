*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to log in with a pre-registered user
    [Tags]    success

    ${data}    Get data    user    login

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]

Should not be able to log in with an unregistered email
    [Tags]    error    unregistered_email

    ${data}    Get data    user    login
    ${user}    Change field value    ${data}    email    email@email.com

    Remove user from database    email    ${user}[email]
    Do login error    ${user}    400    E-mail ou Senha inválidos.

Should not be able to log in with an invalid email
    [Tags]    error    invalid_email

    ${data}    Get data    user    login
    ${user}    Change field value    ${data}    email    email@email

    Remove user from database    email    ${user}[email]
    Do login error    ${user}    400    O Email precisa ser válido.

Should not be able to log in with an incorrect password
    [Tags]    error    incorrect_password

    ${data}    Get data    user    login
    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    ${user}    Change field value    ${data}    password    senha1234

    Do login error    ${user}    400    E-mail ou Senha inválidos.

Should not be able to log in with an invalid password
    [Tags]    error    invalid_password

    ${data}    Get data    user    login

    @{password_list}    Set Variable    1    12    123    1234

    FOR    ${password}    IN    @{password_list}
        ${user}    Copy Dictionary    ${data}[user]
        Set To Dictionary    ${user}    password=${password}
        Set To Dictionary    ${user}    confirmPassword=${password}

        Do login error    ${user}    400    A Senha precisa conter, no mínimo, 5 caracteres.
    END

Required Fields
    [Tags]    error    required

    ${data}    Get data    user    login

    @{required_list}    Set Variable    email    password

    @{name_message_list}    Set Variable
    ...    Email
    ...    Senha

    FOR    ${element}    IN    @{required_list}
        ${user}    Copy Dictionary    ${data}[user]
        Set To Dictionary    ${user}    ${element}=${EMPTY}

        ${index}    Get Index From List    ${required_list}    ${element}
        ${name_message}    Get From List    ${name_message_list}    ${index}

        IF    '${element}' == 'password'
            ${message}    Set Variable    A Senha é obrigatória.
        ELSE
            ${message}    Set Variable    O ${name_message} é obrigatório.
        END

        Do login error    ${user}    400    ${message}
    END
