*** Settings ***
Resource    ../main.robot


*** Variables ***
&{dadosRegistro}
...                 PrimeiroNome=Edward
...                 UltimoNome=Sheeran
...                 Telefone=555-431
...                 Email=teste@gmail.com
...                 Senha=123456


*** Keywords ***
E realize o cadastro
    Wait Until Element Is Visible    ${home.A_Signup}    10
    Click Element    ${home.A_Signup}
    Wait Until Element Is Visible    ${registro.Input_PrimeiroNome}    10
    Input Text    ${registro.Input_PrimeiroNome}    ${dadosRegistro.PrimeiroNome}
    Wait Until Element Is Visible    ${registro.Input_UltimoNome}    10
    Input Text    ${registro.Input_UltimoNome}    ${dadosRegistro.UltimoNome}
    Wait Until Element Is Visible    ${registro.Input_Telefone}    10
    Input Text    ${registro.Input_Telefone}    ${dadosRegistro.Telefone}
    Wait Until Element Is Visible    ${registro.Input_Email}    10
    Input Text    ${registro.Input_Email}    ${dadosRegistro.Email}
    Wait Until Element Is Visible    ${registro.Input_Senha}    10
    Input Text    ${registro.Input_Senha}    ${dadosRegistro.Senha}
    Wait Until Element Is Visible    ${registro.Button_Cookie}    10
    Click Element    ${registro.Button_Cookie}
    Wait Until Element Is Visible    ${registro.Button_Signup}    10
    Sleep    2s
    Run Keyword And Ignore Error    Click Element    ${registro.Button_Signup}
    Click Element    ${registro.Button_Signup}
