*** Settings ***
Library     ../../resources/database/database.py
Resource    ../../resources/main.resource


*** Test Cases ***
Must be able to register a new user
    [Tags]    success

    ${data}    Get data    user    register

    Remove user from database    email    ${data}[user][email]
    Register user    ${data}[user]    201

Must be able to register a new user without cpf
    [Tags]    success    no_cpf

    ${data}    Get data    user    register
    ${user}    Change field value    ${data}    cpf    ${EMPTY}

    Remove user from database    email    ${data}[user][email]
    Register user    ${user}    201

Must be able to register a new user without phone
    [Tags]    success    no_phone

    ${data}    Get data    user    register
    ${user}    Change field value    ${data}    phone    ${EMPTY}

    Remove user from database    email    ${data}[user][email]
    Register user    ${user}    201

Registration with duplicate email should not be allowed
    [Tags]    error    duplicate_email

    ${data}    Get data    user    register

    Remove user from database    email    ${data}[user][email]
    Insert user into database    ${data}[user]

    Register user error    ${data}[user]    400    E-mail já cadastrado.

Registration with duplicate cpf should not be allowed
    [Tags]    error    duplicate_cpf

    ${data}    Get data    user    register

    Remove user from database    cpf    ${data}[user][cpf]
    Insert user into database    ${data}[user]

    Register user error    ${data}[userCpf]    400    CPF já cadastrado.

Should not register with an incorrect email
    [Tags]    error    invalid_email

    ${data}    Get data    user    register
    ${user}    Change field value    ${data}    email    email@email

    Remove user from database    email    ${data}[user][email]
    Register user error    ${user}    400    O Email precisa ser válido.

Should not register with an incorrect cpf
    [Tags]    error    invalid_cpf

    ${data}    Get data    user    register
    ${user}    Change field value    ${data}    cpf    12345678910

    Remove user from database    cpf    ${data}[user][cpf]
    Register user error    ${user}    400    CPF inválido

Should not register with an incorrect password
    [Tags]    error    invalid_password

    ${data}    Get data    user    register

    @{password_list}    Set Variable    1    12    123    1234

    FOR    ${password}    IN    @{password_list}
        ${user}    Copy Dictionary    ${data}[user]
        Set To Dictionary    ${user}    password=${password}
        Set To Dictionary    ${user}    confirmPassword=${password}

        Register user error    ${user}    400    A Senha precisa conter, no mínimo, 5 caracteres.
    END

Should not be able to register with different passwords
    [Tags]    error    different_passwords

    ${data}    Get data    user    register
    ${user}    Change field value    ${data}    confirmPassword    senha1234

    Remove user from database    email    ${data}[user][email]
    Register user error    ${user}    400    As senhas não coincidem.

Required Fields
    [Tags]    error    required

    ${data}    Get data    user    register

    @{required_list}    Set Variable    firstName    lastName    email    password

    @{name_message_list}    Set Variable
    ...    Primeiro Nome
    ...    Último Nome
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

        Register user error    ${user}    400    ${message}
    END
