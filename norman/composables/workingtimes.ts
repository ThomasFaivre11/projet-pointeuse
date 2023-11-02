const workingtimes = () => {
    let url = "http://10.18.206.168:4000/api/";
    async function createWorkingTimes(user_id: string, start: string, end: string){
        try{
            url += `workingtimes/${user_id}`
            const wtData = {
                start: `${start}`,
                end: `${end}`
            }
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({workingtime: wtData})
            })
            if (!response.ok){
                throw new Error(`Erreur HTTP! Statut: ${response.status}`);
            }else {
                console.log("workingtime créer :)")
            }
        }catch (error) {
            console.log(error)
            console.log("problème de création d'un working time !")
        }
    }

    async function updateWorkingTime(user_id: string, start: string, end: string){
        try{
            const dynamic_url = url+`workingtimes/${user_id}`;
            const wtData = {
                start: `${start}`,
                end: `${end}`
            }
            const response = await fetch(dynamic_url, {
                method: "PUT",
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({workingtime: wtData})
            });
            response.ok ? console.log("workingtime est update") : console.log("Erreur lors update workingtime")
        }catch (e) {
            console.log(e);
            console.log("problème update de workingtime")
        }
    }

    async function deleteWorkingTime(workingtime_id: string){
        try{
            url += `workingtimes/${workingtime_id}`
            const response = fetch(url, {
                method: "DELETE",
            });
            console.log("workingtime est delete")
        }catch (e) {
            console.log(e);
            console.log("problème delete du workingtime")
        }
    }

    async function getWorkingTime(user_id: string, workingtime_id: string){

        if (user_id != "" && workingtime_id != ""){
            url += `workingtimes/${user_id}/${workingtime_id}`;
        }else if (user_id != "" && workingtime_id == ""){
            url += `workingtimes/${user_id}`;
        }else {
            console.log("veuillez vérifier les valeurs en paramètres")
        }

        console.log(url);

        try {
            console.log("Requesting:", url); // Debug: vérifiez l'URL
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error(`Erreur HTTP! Statut: ${response.status}`);
            }
            const result = await response.json();
            if (result && result.data) {
                return result.data;
            } else {
                console.log("Réponse inattendue:", result);
                return null;
            }
        } catch (e) {
            console.error(e);
            console.log("Erreur de récupération des workingtimes");
            return null;
        }
    }

    return {
        createWorkingTimes,
        updateWorkingTime,
        deleteWorkingTime,
        getWorkingTime
    };
};

export default workingtimes;
