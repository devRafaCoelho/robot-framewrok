*** Settings ***
Resource    ../main.robot


*** Keywords ***
Acessar o site e logar
    Dado que eu acesse o php travels
    E realize o cadastro
    E faça o Login

Fechar navegador
    Close Browser
