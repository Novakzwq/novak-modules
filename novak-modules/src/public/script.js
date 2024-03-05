import { RegisterConfig } from "./config.js";
import { RegisterBarbershop } from "./modules/barbershop/script.js";
import { RegisterKeyboardNav } from "./modules/keyboard_navigation/script.js";
import { RegisterMDT } from "./modules/mdt/script.js";
import { RegisterSkinshop } from "./modules/skinshop/script.js"
import { RegisterTattooshop } from "./modules/tattooshop/script.js";

const Interface = {}

Interface.Actions = {}
Interface.cam = 0;

RegisterConfig(Interface);

RegisterSkinshop(Interface);
RegisterBarbershop(Interface);
RegisterTattooshop(Interface);
RegisterMDT(Interface);

RegisterKeyboardNav(Interface);

document.querySelectorAll(`input[type="range"]`)
.forEach((element, key) => {
    handleInput(element)
    element.addEventListener("input", handleInputChange)
})

document.querySelectorAll(".shop-interface-bottom input")
.forEach((element,key)=>{
    element.oninput = function(){
        $.post("https://novak_modules/rotateCharacter", JSON.stringify({
            heading: this.value
        }))
    }
})

document.querySelectorAll(".cam-button")
.forEach((element,key)=>{
    console.log(element)
    element.onclick = function(){
        console.log(this.dataset.mode)
        switch (this.dataset.mode) {
            case "rem":
                if(Interface.cam <= 0){
                    Interface.cam = 4
                } else {
                    Interface.cam = Interface.cam - 1
                }
                break;
            case "add":
                if(Interface.cam >= 4){
                    Interface.cam = 0
                } else {
                    Interface.cam = Interface.cam + 1
                }
                break;
        }
        $.post("https://novak_modules/selectCam", JSON.stringify({ cam: String(Interface.cam) }) );
    }
})

export function handleInput(element) {
    $(element).css("background-size", `${(element.value - element.min) * 100 / (element.max - element.min)}% 100%`)
}

function handleInputChange(e) {
    let target = e.target
    $(target).css("background-size", `${(target.value - target.min) * 100 / (target.max - target.min)}% 100%`)
}

window.addEventListener("message", (event) => {
    if (!event.data.listener || !event.data.action) return
    if (!Interface.Actions[event.data.listener]) return
    if (!Interface.Actions[event.data.listener][event.data.action]) return
    Interface.Actions[event.data.listener][event.data.action](event.data.data)
})

document.addEventListener("keydown",(event)=>{
    if(!Interface.keyboardNav.mappers[event.code]) return
    Interface.keyboardNav.mappers[event.code](event)
})

document.addEventListener("keydown",(event)=>{
    if(event.code != "Escape") return
    $.post("https://novak_modules/reset");
})