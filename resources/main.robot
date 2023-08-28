*** Settings ***
Library     SeleniumLibrary
### Data ###
Resource    data/geral.robot
Resource    data/registro.robot
### Shared ###
Resource    shared/setupTearDown.robot
### Pages ###
Resource    pages/homePage.robot
Resource    pages/loginPage.robot
Resource    pages/registroPage.robot
Resource    pages/reservaVooPage.robot
Resource    pages/vistoPage.robot
Resource    pages/vooPage.robot
Resource    pages/vooResultadoPage.robot
