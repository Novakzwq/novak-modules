const CrimeManager = {
    multaTotal: 0,
    penaTotal: 0,
    crimes: [],
    add: function(pena,multa,crimeName){
        this.multaTotal = this.multaTotal + multa
        this.penaTotal = this.penaTotal + pena
        this.crimes.push(crimeName)
        this.update()
    },
    remove: function(pena,multa,crimeName){
        this.multaTotal = this.multaTotal - multa
        this.penaTotal = this.penaTotal - pena
        this.crimes.splice(1,1,crimeName)
        this.update()
    },
    update: function(){
        document.getElementById("pena_total").value = this.penaTotal
        document.getElementById("multa_total").value = this.multaTotal
    }
}

export function RegisterMDT(Interface){
    Interface.mdt = {}
    Interface.mdt.Config = {}
    Interface.Actions.mdt = {}

    Interface.mdt.Elements = {
        main: document.querySelector(".mdt-interface"),
        pages: {
            all: document.querySelectorAll(".mdt-content > *")
        },
        sidebarItens: document.querySelectorAll(".mdt-sidebar-item"),
        loader: document.querySelector(".mdt-content-loader")
    }

    RegisterPages(Interface);
    RegisterPopup(Interface);

    Interface.Actions.mdt.show = function(data){
        Interface.Actions.mdt.reset();
        $(Interface.mdt.Elements.main).show("slow");
        Interface.mdt.Pages.home.show();
        Interface.mdt.Config = data.config
        if(data.profile) document.querySelector(".mdt-header-profile").style.backgroundImage = `url(${(data.profile) ? data.profile : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"})`
    }

    Interface.Actions.mdt.reset = function(data){
        Interface.mdt.Pages.Functions.reset()
        $(Interface.mdt.Elements.sidebarItens).removeClass("selected");
    }

    Interface.Actions.mdt.hide = function(){
        $(Interface.mdt.Elements.main).hide("fast");
        Interface.Actions.mdt.reset();
    }

    const announceMessage = document.querySelector(".mdt-announcements-send-announce")

    announceMessage.querySelector("div")
    .onclick = async function(){
        const message = announceMessage.querySelector("input").value
        if(!message || message == "" || message == " ") return
        announceMessage.querySelector("input").value = "";
        const res = await fetch(`https://${GetParentResourceName()}/sendannoucements`,{
            method: "POST",
            body: JSON.stringify({
                message
            })
        })
        const result = await res.json();
        document.querySelector(".mdt-announcements-content").innerHTML = "";
        for (let i = 0; i < result.length; i++) {
            const element = result[i];
            $(".mdt-announcements-content").append(`
                <div class="mdt-announcements-single">
                    <div class="mdt-announcements-single-profile mdt-background-image" style="background-image: url(${(element.photo) ? element.photo : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"})">

                    </div>
                    <div class="mdt-announcements-single-content">
                        <p>${element.name}</p>
                        <span>
                            ${element.message}
                        </span>
                    </div>
                </div>
            `)
        }
    }

    document.querySelector(".mdt-header-profile .change-photo-button")
    .addEventListener("click",()=>{
        Interface.mdt.popup.Functions.open({
            title: "Digite o url da sua foto de perfil",
            wButtons: true,
            callbackfn: async function(){
                console.log("BOM DIA")
                const url = document.querySelector(".mdt-popup-cnt-input input")

                if(url.value == "" || url.value.replace(" ","") == "") return

                const res = await fetch(`https://${GetParentResourceName()}/changephoto`,{
                    method: "POST",
                    body: JSON.stringify({ url: url.value.replace(" ","") })
                })

                const result = await res.json();

                if(result.success) document.querySelector(".mdt-header-profile").style.backgroundImage = `url(${url.value})`
                Interface.mdt.popup.Functions.close()
                url.value = ""
            },
            content:{
                input: true
            }
        })
    })

    document.querySelector(".mdt-content-home .mdt-content-home-offices input")
    .addEventListener("input",function(){

        document.querySelectorAll(".mdt-offices-list-single")
        .forEach((element,key)=>{
            if(this.value == "" || this.value.replace(" ","") == "") $(element).show()
            const officeName = element.querySelector(".mdt-single-office-content-first .name")
            if(officeName.innerHTML.toLocaleLowerCase().replace(" ","").includes(this.value.toLocaleLowerCase().replace(" ",""))){
                $(element).show()
            } else {
                $(element).hide()
            }
        })
    })

    document.querySelector(".mdt-content-ficha .mapreedev-button")
    .addEventListener("click",async()=>{
        const input = document.querySelector(".mdt-content-ficha input")
        if(input.value.replace(" ","") == "") return
        const res = await fetch(`https://${GetParentResourceName()}/searchficha`,{
            method: "POST",
            body: JSON.stringify({
                id: input.value.replace(" ","").replace("+","").replace("-","")
            })
        })
        const result = await res.json()

        if(!result.name) return

        $(".mdt-ficha-list").html("")

        const FichaCnt = document.createElement("div");
        
        FichaCnt.classList.add("mdt-single-ficha-list");
        FichaCnt.classList.add("mapree-dev-background-b");
        
        const FichaFirst = document.createElement("div");
        
        FichaFirst.classList.add("mdt-single-ficha-first");

        const FichaFirstIMG = document.createElement("div");

        FichaFirstIMG.classList.add("mdt-single-office-image");
        FichaFirstIMG.classList.add("mdt-background-image");

        FichaFirstIMG.style.backgroundImage = `url(${(result.photo) ? result.photo : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"})`

        const FichaFirstContent = document.createElement("div");

        FichaFirstContent.classList.add("mdt-single-ficha-content");

        const FichaName = document.createElement("span");

        FichaName.classList.add("mdt-single-ficha-name");

        FichaName.innerText = result.name

        const FichaStatus = document.createElement("div");

        if(result.ficha){
            FichaStatus.classList.add("mdt-single-ficha-status");
            FichaStatus.classList.add("mdt-single-status-negative");
    
            FichaStatus.innerHTML = "SUJA"
        }

   
        
        const FichaSecond = document.createElement("div");

        FichaSecond.classList.add("mdt-single-ficha-second");

        const ViewFicha = document.createElement("div");

        ViewFicha.classList.add("mdt-single-ficha-button")
        ViewFicha.classList.add("mapree-dev-background-b")

        ViewFicha.innerHTML = "VER FICHA"

        ViewFicha.onclick = function(){
            Interface.mdt.popup.Functions.open({
                title: `Ficha de ${result.name}`,
                content: {
                    custom: `${(result.ficha) ? MapFicha(result.ficha) : "Não tem ficha" }`,
                }
            })
        }

        function MapFicha(ficha){
            console.log("BOM")
            let Ficha = JSON.parse(ficha)
            let FichaHTML = ``
            for (let i = 0; i < Ficha.length; i++) {
                const element = Ficha[i];
                console.log("ELEMENT",element,Ficha,typeof(Ficha))
                FichaHTML = ` ${FichaHTML}
                <div class="mapree-dev-background-b mdt-popup-ficha-item">
                    ${element}
                </div>
                `
            }
            console.log(FichaHTML)
            return FichaHTML
        }

        const ViewVehicles = document.createElement("div");

        ViewVehicles.classList.add("mdt-single-ficha-button")
        ViewVehicles.classList.add("mapree-dev-background-b")

        ViewVehicles.innerHTML = "VEICULOS"

        ViewVehicles.onclick = function(){
            Interface.mdt.popup.Functions.open({
                title: `Veiculos de ${result.name}`,
                content:{
                    list:{
                        type: "car",
                        data: result.vehicles,
                        
                    }
                },
                user_id: result.user_id
            })
        }

        FichaSecond.appendChild(ViewFicha);
        FichaSecond.appendChild(ViewVehicles);

        FichaFirstContent.appendChild(FichaName);
        FichaFirstContent.appendChild(FichaStatus);

        FichaFirst.appendChild(FichaFirstIMG);
        FichaFirst.appendChild(FichaFirstContent);

        FichaCnt.appendChild(FichaFirst);
        FichaCnt.appendChild(FichaSecond);
        
        $(".mdt-ficha-list").append(FichaCnt);


    })

    document.getElementById("crime_multar").onclick = async function(){
        const res = await fetch(`https://${GetParentResourceName()}/multar`,{
            method: "POST",
            body: JSON.stringify({
                id: document.getElementById("crime_id").value,
                price: document.getElementById("multa_total").value
            })
        })
        
        const result = await res.json()

        if(result.status) document.getElementById("multa_total").value = "0"
    }

    document.getElementById("crime_prender").onclick = async function(){
        const res = await fetch(`https://${GetParentResourceName()}/prender`,{
            method: "POST",
            body: JSON.stringify({
                id: document.getElementById("crime_id").value,
                months: document.getElementById("pena_total").value,
                crimes: CrimeManager.crimes
            })
        })

        const result = await res.json()

        if(result.status) document.getElementById("pena_total").value = "0"
    }

    document.querySelector(".mdt-content-punish .mdt-content-punish-top input")
    .addEventListener("input",function(){

        document.querySelectorAll(".mdt-punish-single-crime")
        .forEach((element,key)=>{
            if(this.value == "" || this.value.replace(" ","") == "") $(element).show()
            const CrimeName = element.querySelector(".name")
            if(CrimeName.innerHTML.toLocaleLowerCase().replace(" ","").includes(this.value.toLocaleLowerCase().replace(" ",""))){
                $(element).show()
            } else {
                $(element).hide()
            }
        })
    })


    document.querySelector(".mdt-content-emp-top .mapreedev-button")
    .addEventListener("click",async()=>{
        console.log("OPA")
        const input = document.querySelector(".mdt-content-emp-top input")
        if(input.value.replace(" ","") == "") return console.log("invalid input")
        const res = await fetch(`https://${GetParentResourceName()}/searchemp`,{
            method: "POST",
            body: JSON.stringify({
                id: input.value
            })
        })
        const result = await res.json()

        document.querySelector(".mdt-content-emp-body").innerHTML = "";
        input.value = ""

        const mainDiv = document.createElement("div")

        mainDiv.classList.add("mdt-content-emp-single")
        mainDiv.classList.add("mapree-dev-background-b")

        const profileDiv = document.createElement("div")
        
        profileDiv.classList.add("mdt-content-single-emp-profile")

        const profileAvatarDiv = document.createElement("div")

        profileAvatarDiv.classList.add("mdt-emp-single-avatar")
        profileAvatarDiv.classList.add("mdt-background-image")

        profileAvatarDiv.style.backgroundImage = `url(${(result.photo) ? result.photo : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" })`

        const profileInfosDiv = document.createElement("div")

        profileInfosDiv.classList.add("mdt-emp-single-infos")

        const profileInfosName = document.createElement("span");

        profileInfosName.innerHTML = result.name

        const profileInfosJob = document.createElement("span");

        profileInfosJob.innerHTML = `${(result.job.currentGrade) ? result.job.currentGrade.group : "Não é um oficial" }`

        profileInfosDiv.append(profileInfosName);
        profileInfosDiv.append(profileInfosJob);

        profileDiv.appendChild(profileAvatarDiv)
        profileDiv.appendChild(profileInfosDiv);

        const buttonContainer = document.createElement("div")

        buttonContainer.classList.add("mdt-content-single-emp-actions")

        const ContractButton = document.createElement("div")

        ContractButton.innerHTML = "CONTRATAR";

        ContractButton.classList.add("mdt-emp-single-button")
        ContractButton.classList.add("mapree-dev-background-brand")

        ContractButton.onclick = async function(){
            await fetch(`https://${GetParentResourceName()}/contract`,{
                method: "POST",
                body: JSON.stringify({
                    user_id: result.user_id,
                })
            })
            fetch(`https://${GetParentResourceName()}/searchemp`,{
                method: "POST",
                body: JSON.stringify({
                    id: result.user_id
                })
            })
        }

        const Dimiss = document.createElement('div');

        Dimiss.classList.add("mdt-emp-single-button");
        Dimiss.classList.add("mdt-emp-single-button-dimiss");

        Dimiss.innerHTML = "DEMITIR";

        Dimiss.onclick = async function(){
            await fetch(`https://${GetParentResourceName()}/dimiss`,{
                method: "POST",
                body: JSON.stringify({
                    user_id: result.user_id,
                })
            })
            fetch(`https://${GetParentResourceName()}/searchemp`,{
                method: "POST",
                body: JSON.stringify({
                    id: result.user_id
                })
            })
        }

        const Upgrade = document.createElement("div");

        Upgrade.classList.add("mdt-emp-single-button");
        Upgrade.classList.add("mapree-dev-background-brand");

        Upgrade.innerHTML = "PROMOVER";

        Upgrade.onclick = async function(){
            await fetch(`https://${GetParentResourceName()}/upgrade`,{
                method: "POST",
                body: JSON.stringify({
                    user_id: result.user_id,
                })
            })
            fetch(`https://${GetParentResourceName()}/searchemp`,{
                method: "POST",
                body: JSON.stringify({
                    id: result.user_id
                })
            })
        }
        
        const Downgrade = document.createElement("div");

        Downgrade.classList.add("mdt-emp-single-button");
        Downgrade.classList.add("mdt-emp-single-button-downgrade");

        Downgrade.innerHTML = "REBAIXAR";

        Downgrade.onclick = async function(){
            await fetch(`https://${GetParentResourceName()}/downgrade`,{
                method: "POST",
                body: JSON.stringify({
                    user_id: result.user_id,
                })
            })
            fetch(`https://${GetParentResourceName()}/searchemp`,{
                method: "POST",
                body: JSON.stringify({
                    id: result.user_id
                })
            })
        }

        if(result.job.currentGrade){
            buttonContainer.appendChild(Dimiss)
            buttonContainer.appendChild(Upgrade)
            buttonContainer.appendChild(Downgrade)
        } else {
            buttonContainer.appendChild(ContractButton);
        }

        mainDiv.appendChild(profileDiv)
        mainDiv.appendChild(buttonContainer)

        document.querySelector(".mdt-content-emp-body").appendChild(mainDiv);
    })

}

function RegisterPopup(Interface){
    Interface.mdt.popup = {}

    Interface.mdt.popup.Functions = {}

    Interface.mdt.popup.Functions.open = function(data){
        Interface.mdt.popup.Functions.reset();
        if(data.title) {
            $(".mdt-popup-title").show()
            document.querySelector(".mdt-popup-title").innerHTML = data.title;
        }
        if(data.wButtons) $(".mdt-popup-buttons").show();
        if(data.callbackfn) document.querySelector(".mdt-popup-buttons .mdt-popup-buttons-confirm").onclick = data.callbackfn;
        if(data.content){
            $(".mdt-popup-content").show();
            if(data.content.input){
                const input = document.createElement("input")
                input.setAttribute("type","text")
                document.querySelector(".mdt-popup-cnt-input").appendChild(input)
                $(".mdt-popup-cnt-input").show();
            }
            if(data.content.custom) {
                $(".mdt-popup-cnt-custom").show()
                document.querySelector(".mdt-popup-cnt-custom").innerHTML = data.content.custom
            }
            if(data.content.list){
                $(".mdt-popup-cnt-list").show()
                document.querySelector(".mdt-popup-cnt-list").innerHTML = "";
                switch (data.content.list.type) { 
                    case "car":
                        for (let i = 0; i < data.content.list.data.length; i++) {
                            const element = data.content.list.data[i];
                            const mainDiv = document.createElement("div");

                            mainDiv.classList.add("mapree-dev-background-b")
                            mainDiv.classList.add("mdt-popup-cnt-list-car")

                            const image = document.createElement("img")
                            
                            image.setAttribute("src",`http://167.114.223.179/fotos_premiumX/${element.index}.png` )
                            
                            const infos = document.createElement("div")

                            infos.classList.add("mdt-popup-list-car-infos")

                            const infosSpan = document.createElement("span")

                            infosSpan.innerHTML = `${(element.name) ? element.name : "Desconhecido"}`

                            const canDeterButton = document.createElement("div")


                            canDeterButton.innerText = "DETER"

                            if(element.detido){
                                canDeterButton.classList.remove("mdt-popup-buttons-recuse")
                                canDeterButton.innerHTML = "LIBERAR"
                            } else {
                                canDeterButton.classList.add("mdt-popup-buttons-recuse")
                                canDeterButton.innerHTML = "DETER"
                            }

                            canDeterButton.classList.add("mdt-popup-button")

                            canDeterButton.onclick = async function(){
                                    const res = await fetch(`https://${GetParentResourceName()}/deter`,{
                                        method: "POST",
                                        body: JSON.stringify({
                                            vehicle: element.index,
                                            user_id: data.user_id,
                                            status: canDeterButton.classList.contains("mdt-popup-buttons-recuse")
                                        })
                                    })

                                    const result = await res.json()

                                    if(result.detido){
                                        canDeterButton.classList.remove("mdt-popup-buttons-recuse")
                                        canDeterButton.innerHTML = "LIBERAR"
                                    } else {
                                        canDeterButton.classList.add("mdt-popup-buttons-recuse")
                                        canDeterButton.innerHTML = "DETER"
                                    }
                                console.log("DETER CARRO")
                            }
                            

                            infos.appendChild(infosSpan)
                            infos.appendChild(canDeterButton)

                            mainDiv.appendChild(image)
                            mainDiv.appendChild(infos)

                            $(".mdt-popup-cnt-list").append(mainDiv)

                            // $(".mdt-popup-cnt-list").append(`
                            // <div class="mdt-popup-cnt-list-car mapree-dev-background-b">
                            //     <img src="http://167.114.223.179/fotos_premiumX/${element.index}.png" alt="" srcset="">
                            //     <div class="mdt-popup-list-car-infos">
                            //         <span>
                            //             ${(element.name) ? element.name : "Desconhecido"}
                            //         </span>
                            //         <div class="mdt-popup-button mdt-popup-buttons-recuse">
                            //             DETER
                            //         </div>
                            //     </div>
                            // </div>
                            // `);
                        }
                        console.log("CAR LIST");
                        break;
                }
            }
           
        }


        $(".mdt-popup").show("slow");
    }

    Interface.mdt.popup.Functions.reset = function(){
        $(".mdt-popup-buttons").hide();
        $(".mdt-popup-content").hide();
        $(".mdt-popup-title").hide();
        $(".mdt-popup-cnt-input").hide();
        $(".mdt-popup-cnt-custom").hide();
        document.querySelectorAll(".mdt-popup-content > *")
        .forEach((element,key)=>{
            element.innerHTML = "";
            $(element).hide();
        })
    }


    Interface.mdt.popup.Functions.close = function(){
        $(".mdt-popup").hide("slow");
        Interface.mdt.popup.Functions.reset()
    }

    document.querySelectorAll(".popup-mdt-can-close")
    .forEach((element,key)=>{
        element.onclick = function(){
            Interface.mdt.popup.Functions.close()
        }
    })
}

function RegisterPages(Interface){
    Interface.mdt.Pages = {}

    Interface.mdt.Pages.Functions = {}

    Interface.mdt.Pages.Functions.reset = function(){
        Interface.mdt.Elements.pages.all
        .forEach((element,key)=>{
            console.log(element.classList)
            $(element).hide();
        })
        $(".mdt-content-loader").hide()
    }

    Interface.mdt.Elements.sidebarItens
    .forEach((element,key)=>{
        element.onclick = function(){
            if(this.classList.contains("selected")) return
            $(Interface.mdt.Elements.sidebarItens).removeClass("selected");
            Interface.mdt.Pages.Functions.reset()
            
            Interface.mdt.Pages[this.dataset.page].show("slow");
        }
    })

    Interface.mdt.Pages.home = {}
    Interface.mdt.Pages.home.show = async function(){
        document.querySelector(`.mdt-sidebar-item[data-page="home"]`).classList.add("selected")
        

        $(Interface.mdt.Elements.loader).show()
        Interface.mdt.Pages.home.reset()

        const res = await fetch(`https://${GetParentResourceName()}/home`,{
            method: "POST"
        })

        const result = await res.json();

        for (let i = 0; i < result.offices.length; i++) {
            const element = result.offices[i];


          

            const mdtOficcesListSingle = document.createElement("div");

            mdtOficcesListSingle.classList.add("mapree-dev-background-b")
            mdtOficcesListSingle.classList.add("mdt-offices-list-single")

            const mdtOfficeImage = document.createElement("div")

            mdtOfficeImage.style.backgroundImage = `url(${(element.photo) ? element.photo : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"})`

            mdtOfficeImage.classList.add("mdt-background-image")
            mdtOfficeImage.classList.add("mdt-single-office-image")

            const mdtOfficeContent = document.createElement("div")

            mdtOfficeContent.classList.add("mdt-single-office-content");

            const mdtOfficeContentFirst = document.createElement("div");

            mdtOfficeContentFirst.classList.add("mdt-single-office-content-first");

            const mdtOfficeContentFirstSP = document.createElement("span");
            const mdtOfficeContentFirstSP2 = document.createElement("span");

            mdtOfficeContentFirstSP.classList.add("name")
            mdtOfficeContentFirstSP.innerText = element.name
            mdtOfficeContentFirstSP2.innerText = element.grade

            const mdtOfficeContentSecond = document.createElement("div");

            mdtOfficeContentSecond.classList.add("mdt-single-office-content-second");

            const upgradeButton = document.createElement("div");

            upgradeButton.innerHTML = "PROMOVER"

            upgradeButton.classList.add("mdt-single-office-button")
            upgradeButton.classList.add("mdt-single-button-upgrade")

            upgradeButton.onclick = async function(){
                await fetch(`https://${GetParentResourceName()}/upgrade`,{
                    method: "POST",
                    body: JSON.stringify({
                        user_id: element.user_id
                    })
                })
                setTimeout(() => {
                    Interface.mdt.Pages.home.show()
                }, 1000);
            }

            const downgradeButton = document.createElement("div");

            downgradeButton.innerHTML = "REBAIXAR"

            downgradeButton.classList.add("mdt-single-office-button");
            downgradeButton.classList.add("mdt-single-button-downgrade")

            downgradeButton.onclick = async function(){
                await fetch(`https://${GetParentResourceName()}/downgrade`,{
                    method: "POST",
                    body: JSON.stringify({
                        user_id: element.user_id
                    })
                })

                setTimeout(() => {
                    Interface.mdt.Pages.home.show()
                }, 1000);
            }

            const dimissButton = document.createElement("div");

            dimissButton.innerHTML = "DEMITIR"

            dimissButton.classList.add("mdt-single-office-button");
            dimissButton.classList.add("mdt-single-button-dimiss")

            dimissButton.onclick = async function(){
                await fetch(`https://${GetParentResourceName()}/dimiss`,{
                    method: "POST",
                    body: JSON.stringify({
                        user_id: element.user_id
                    })
                })

                setTimeout(() => {
                    Interface.mdt.Pages.home.show()
                }, 1000);
            }

            mdtOfficeContentFirst.appendChild(mdtOfficeContentFirstSP)
            mdtOfficeContentFirst.appendChild(mdtOfficeContentFirstSP2);

            mdtOfficeContentSecond.appendChild(upgradeButton);
            mdtOfficeContentSecond.appendChild(downgradeButton);
            mdtOfficeContentSecond.appendChild(dimissButton);

            mdtOfficeContent.appendChild(mdtOfficeContentFirst);
            mdtOfficeContent.appendChild(mdtOfficeContentSecond);

            mdtOficcesListSingle.appendChild(mdtOfficeImage);
            mdtOficcesListSingle.appendChild(mdtOfficeContent);

            $(".mdt-offices-list").append(mdtOficcesListSingle)
        }

        for (let i = 0; i < result.announcements.length; i++) {
            const element = result.announcements[i];
            $(".mdt-announcements-content").append(`
                <div class="mdt-announcements-single">
                    <div class="mdt-announcements-single-profile mdt-background-image" style="background-image: url(${(element.photo) ? element.photo : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"})">

                    </div>
                    <div class="mdt-announcements-single-content">
                        <p>${element.name}</p>
                        <span>
                            ${element.message}
                        </span>
                    </div>
                </div>
            `)
        }

        $(Interface.mdt.Elements.loader).hide()

        $(document.querySelector(`.mdt-content-home`)).show("slow");
        

    }

    Interface.mdt.Pages.home.reset = function(){
        document.querySelector(".mdt-offices-list").innerHTML = "";
        document.querySelector(".mdt-announcements-content").innerHTML = "";
    }

    Interface.mdt.Pages.home.hide = function(){
        $(`.mdt-content-home`).hide("slow");
    }

    Interface.mdt.Pages.ficha = {}
    Interface.mdt.Pages.ficha.show = function(){
        document.querySelector(`.mdt-sidebar-item[data-page="ficha"]`).classList.add("selected")
        
        Interface.mdt.Pages.ficha.reset()

        $(document.querySelector(`.mdt-content-ficha`)).show("slow");
    }

    Interface.mdt.Pages.ficha.reset = function(){
        document.querySelector(".mdt-ficha-list").innerHTML = "";
    }

    Interface.mdt.Pages.ficha.hide = function(){
        $(document.querySelector(`.mdt-content-ficha`)).hide("slow");
    }

    Interface.mdt.Pages.punish = {}
    Interface.mdt.Pages.punish.show = async function(){
        document.querySelector(`.mdt-sidebar-item[data-page="punish"]`).classList.add("selected")
        let totalPena = 0
        let totalMulta = 0
        Interface.mdt.Pages.punish.reset()
        $(`.mdt-content-punish`).show("slow");
        
        for (let i = 0; i < Interface.mdt.Config.crimes.length; i++) {
            const crime = Interface.mdt.Config.crimes[i];
            
            const mainDiv = document.createElement("div");
            mainDiv.classList.add("mdt-punish-single-crime");
            mainDiv.classList.add("mapree-dev-background-b");

            const crimeSpan = document.createElement("span")
            crimeSpan.innerHTML = crime.name;

            crimeSpan.classList.add("name")

            const penaSpan = document.createElement("span")
            penaSpan.innerHTML = `${crime.pena} MESES`

            const multaSpan = document.createElement("span")
            multaSpan.innerHTML = `${crime.multa.toLocaleString('pt-BR', {
                style: 'currency',
                currency: 'BRL',
            })}`

            const checkBoxSpan = document.createElement("span")
            checkBoxSpan.setAttribute("checkbox","true")

            const checkBoxInput = document.createElement("input")
            checkBoxInput.type = "checkbox"

            checkBoxInput.oninput = function(){
                if(this.checked){
                    CrimeManager.add(crime.pena,crime.multa,crime.name)
                } else {
                    CrimeManager.remove(crime.pena,crime.multa,crime.name)
                }
            }

            checkBoxSpan.appendChild(checkBoxInput)

            mainDiv.appendChild(crimeSpan)
            mainDiv.appendChild(penaSpan)
            mainDiv.appendChild(multaSpan)
            mainDiv.appendChild(checkBoxSpan)


            document.querySelector(".mdt-content-punish-body-crimes").appendChild(mainDiv)

        }

    }

    Interface.mdt.Pages.punish.reset = function(){
        document.querySelector(".mdt-content-punish-body-crimes").innerHTML = "";
        document.getElementById("pena_total").value = 0
        document.getElementById("multa_total").value = 0
        document.getElementById("crime_id").value = 0
    }

    Interface.mdt.Pages.punish.hide = function(){
        $(document.querySelector(`.mdt-content-ficha`)).hide("slow");
    }

    Interface.mdt.Pages.emp = {}
    Interface.mdt.Pages.emp.show = function(){
        document.querySelector(`.mdt-sidebar-item[data-page="emp"]`).classList.add("selected")
        $(document.querySelector(`.mdt-content-emp`)).show("slow");
        Interface.mdt.Pages.emp.reset()
    }

    Interface.mdt.Pages.emp.reset = function(){
        document.querySelector(".mdt-content-emp-body").innerHTML = "";
    }

    Interface.mdt.Pages.emp.hide = function(){
        $(`.mdt-content-ficha`).hide("slow");
    }


}
