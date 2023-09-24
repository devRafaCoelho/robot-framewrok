*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to edit the password of the logged in user
    [Tags]    success

    ${data}    Get data    user    newPassword

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]
    New password    ${data}[new]    204

Should not be able to edit logged-in user password for an invalid password
    [Tags]    error    invalid_password

    ${data}    Get data    user    newPassword

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]

    ${new}    Copy Dictionary    ${data}[new]
    Set To Dictionary    ${new}    password=senha123456

    New password error    ${new}    400    Senha inválida.

Should not be able to edit logged-in user password for an diferent new passwords
    [Tags]    error    diferent_passwords

    ${data}    Get data    user    newPassword

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Do login    ${data}[user]

    ${new}    Copy Dictionary    ${data}[new]
    Set To Dictionary    ${new}    confirmNewPassword=senha123456

    New password error    ${new}    400    As senhas não coincidem.

Required Fields
    [Tags]    error    required

    ${data}    Get data    user    newPassword

    @{required_list}    Set Variable    password    newPassword

    @{name_message_list}    Set Variable
    ...    Senha
    ...    Nova Senha

    FOR    ${element}    IN    @{required_list}
        ${new}    Copy Dictionary    ${data}[new]
        Set To Dictionary    ${new}    ${element}=${EMPTY}

        ${index}    Get Index From List    ${required_list}    ${element}
        ${name_message}    Get From List    ${name_message_list}    ${index}

        ${message}    Set Variable    A ${name_message} é obrigatória.

        Do login    ${data}[user]
        New password error    ${new}    400    ${message}
    END
