*** Settings ***
Documentation       Consuming user routes

Resource            ../main.resource


*** Keywords ***
Register user
    [Arguments]    ${body}    ${status}

    POST    url=${url}/user
    ...    json=${body}
    ...    expected_status=${status}

Register user error
    [Arguments]    ${body}    ${status}    ${expectedMessage}

    ${response}    POST    url=${url}/user
    ...    json=${body}
    ...    expected_status=${status}

    ${message}    Set Variable    ${response.json()}[error][message]
    Should Be Equal As Strings    ${message}    ${expectedMessage}

Do login
    [Arguments]    ${user}

    ${body}    Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${response}    POST    url=${url}/login
    ...    json=${body}
    ...    expected_status=201

    ${token}    Set Variable    ${response.json()}[token]
    Set Test Variable    ${token}

Do login error
    [Arguments]    ${user}    ${status}    ${expectedMessage}

    ${body}    Create Dictionary
    ...    email=${user}[email]
    ...    password=${user}[password]

    ${response}    POST    url=${url}/login
    ...    json=${body}
    ...    expected_status=${status}

    ${message}    Set Variable    ${response.json()}[error][message]
    Should Be Equal As Strings    ${message}    ${expectedMessage}

Detail user
    [Arguments]    ${status}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    GET    url=${url}/user
    ...    headers=${headers}
    ...    expected_status=${status}

Update user
    [Arguments]    ${body}    ${status}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    PUT    url=${url}/user
    ...    headers=${headers}
    ...    json=${body}
    ...    expected_status=${status}

Update user error
    [Arguments]    ${body}    ${status}    ${expectedMessage}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    ${response}    PUT    url=${url}/user
    ...    headers=${headers}
    ...    json=${body}
    ...    expected_status=${status}

    ${message}    Set Variable    ${response.json()}[error][message]
    Should Be Equal As Strings    ${message}    ${expectedMessage}

New password
    [Arguments]    ${body}    ${status}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    PUT    url=${url}/user/newPassword
    ...    headers=${headers}
    ...    json=${body}
    ...    expected_status=${status}

New password error
    [Arguments]    ${body}    ${status}    ${expectedMessage}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    ${response}    PUT    url=${url}/user/newPassword
    ...    headers=${headers}
    ...    json=${body}
    ...    expected_status=${status}

    ${message}    Set Variable    ${response.json()}[error][message]
    Should Be Equal As Strings    ${message}    ${expectedMessage}

Delete user
    [Arguments]    ${status}

    ${headers}    Create Dictionary
    ...    Authorization=Bearer ${token}

    DELETE    url=${url}/user
    ...    headers=${headers}
    ...    expected_status=${status}
