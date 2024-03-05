import { handleInput } from "../../script.js";

export function RegisterTattooshop(Interface){
    Interface.Actions.tattooshop = {}

    Interface.tattooshop = {}

    Interface.tattooshop.currentPart = 1;
    Interface.tattooshop.currentPartName = "mascara";

    Interface.tattooshop.currentColor = 1;
    Interface.tattooshop.currentPrefix = "male";
    Interface.tattooshop.currentStore = 0;
    Interface.tattooshop.selectedColorIndex = 0;

    Interface.Actions.tattooshop.updatePrice = function(data){
        document.querySelector(".tattooshop-interface .tattooshop-price-text").setAttribute("data-value",data.value)
        $(".tattooshop-interface .tattooshop-price-text").text(data.value)
    }

    Interface.Actions.tattooshop.show = function(data){
        Interface.Actions.tattooshop.resetAll();
        $(".tattooshop-interface").fadeIn()
        Interface.tattooshop.currentStore = data.id
        console.log("SEX",data.sex)
        Interface.tattooshop.currentPrefix = data.sex
    }

    Interface.Actions.tattooshop.hide = function(){
        $(".tattooshop-interface").fadeOut()
        Interface.Actions.tattooshop.resetAll();
    }

    Interface.Actions.tattooshop.resetAll = function(){
        Interface.Actions.tattooshop.reset();
        document.querySelectorAll(".rotate-input")
        .forEach((element,key)=>{
            element.value = 0
            handleInput(element)
        });
        let defaultValue = 0
        $(".tattooshop-interface .tattooshop-price-text").text(`${defaultValue.toLocaleString("pt-BR",{ style: "currency", currency: "BRL" })}`)
    }

    Interface.Actions.tattooshop.reset = function(){
        $(".tattooshop-interface .shop-title").fadeOut();
        $(".tattooshop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".tattooshop-interface .shop-products").fadeOut(0);

        $(".tattooshop-interface .shop-categorys").fadeIn();
        $(`.tattooshop-interface .shop-categorys .shop-categorys-page[page="0"]`).fadeIn();
        $(".tattooshop-interface .shop-scroll").fadeIn();
        $(".tattooshop-interface .shop-scroll input").val("0");
        
    }

    Interface.Actions.tattooshop.resetList = function(){
        $(".tattooshop-interface .shop-products-wrapper").html("");
    }

    Interface.Actions.tattooshop.selectCloth = function(){
        // this.dataset.id
        $(".tattooshop-interface .shop-product-single").removeClass("selected");
        $(this).addClass("selected");
        Interface.tattooshop.selectedColorIndex = 0
       
        $.post('http://big_modules/changeTattoo', JSON.stringify({ type: Interface.tattooshop.currentPartName, id: this.dataset.id, color: Interface.tattooshop.selectedColorIndex }));    
    }

    Interface.Actions.tattooshop.changecategory = function(data){
        Interface.Actions.tattooshop.resetList();
        $(".tattooshop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".tattooshop-interface .shop-categorys").fadeOut(0);
        $(".tattooshop-interface .shop-scroll").fadeOut(0);

        $(".tattooshop-interface .shop-products").fadeIn();
        $(".tattooshop-interface .shop-title").fadeIn();
        $(".tattooshop-interface .shop-title .shop-text").text(Interface.tattooshop.currentPartName.toUpperCase())

        Interface.tattooshop.currentPart = data.category

        const tattooshopList = document.querySelector(".tattooshop-interface .shop-products-wrapper")

        console.log(data.part, data.category, JSON.stringify(data))

        for (let i = 0; i < data.tattoo.length; i++) {
            const element = data.tattoo[i];
            // console.log(JSON.stringify(element))

            const div = document.createElement("div")

            div.classList.add("shop-product-single")
            div.classList.add("big-background-b")
            div.classList.add("big-background-border-b")

            div.setAttribute("data-id",i)
            div.setAttribute("data-part",element.part)
            div.setAttribute("data-name",element.name)

            div.onclick = Interface.Actions.tattooshop.selectCloth

            const img = document.createElement("img")

            if (Interface.tattooshop.currentPartName.toLowerCase() == "overlay"){
                img.setAttribute("src", `${Interface.Config.TattooshopImage}${Interface.tattooshop.currentPrefix}/${i}.png`)
            } else {
                img.setAttribute("src", `${Interface.Config.TattooshopImage}${Interface.tattooshop.currentPrefix}/${element.name}.png`)
            }

            

            div.appendChild(img)

            tattooshopList.appendChild(div);
        }

        $('.tattooshop-interface .shop-products').animate({
            scrollTop: 0
        },'fast');
    }

    document.querySelector(".tattooshop-interface .return-button")
    .onclick = function(event){
        if($(".tattooshop-interface .shop-products").is(":visible")){
            Interface.Actions.tattooshop.reset();
        } else {
            Interface.Actions.tattooshop.hide();
            $.post("https://big_modules/reset");
        }
    }

    document.querySelectorAll(".tattooshop-interface .shop-single-category")
    .forEach((element,key)=>{
        element.onclick = function(event){
            const currentEL = event.currentTarget
            Interface.tattooshop.currentPartName = currentEL.dataset.idpart
            $.post('http://big_modules/tattooshopchangePart', JSON.stringify({
                part: Interface.tattooshop.currentPartName,
                sex: Interface.tattooshop.currentPrefix,
                store_id: Interface.tattooshop.currentStore
            }));
        }
    })

    document.querySelector(".tattooshop-interface .shop-price-button")
    .onclick = function(){
        const price = document.querySelector(".tattooshop-interface .tattooshop-price-text").dataset.value
        $.post("https://big_modules/tattooshoppayament", JSON.stringify({ price }));
    }
}