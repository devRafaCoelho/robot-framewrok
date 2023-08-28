*** Settings ***
Resource    ../main.robot


*** Variables ***
&{login}
...         Input_EmailLogin=//input[@placeholder="Email"]
...         Input_SenhaLogin=//input[@placeholder="Password"]
...         Button_Logar=//span[contains(text(),"Login")]
...         A_OpcaoLogin=(//a[@href="https://www.phptravels.net/login"])[2]


*** Keywords ***
Dado que eu acesse o php travels
    Open Browser    ${geral.URL}    ${geral.Browser}
    Maximize Browser Window

E faça o Login
    Wait Until Element Is Visible    ${login.A_OpcaoLogin}    10
    Click Element    ${login.A_OpcaoLogin}
    Wait Until Element Is Visible    ${login.Input_EmailLogin}    10
    Input Text    ${login.Input_EmailLogin}    ${dadosRegistro.Email}
    Wait Until Element Is Visible    ${login.Input_SenhaLogin}    10
    Input Text    ${login.Input_SenhaLogin}    ${dadosRegistro.Senha}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${registro.Button_Cookie}    5
    Run Keyword And Ignore Error    Click Element    ${registro.Button_Cookie}
    Wait Until Element Is Visible    ${login.Button_Logar}    10
    Click Element    ${login.Button_Logar}
