
const manager_token = () => {

    async function search_id_manager(token: string){
        let id_manager = ""
        // recherche de l'id du manager par rapport au token
        const url = 'http://localhost:4000/api/searchIdManager/' + token
        const reponse = await fetch(url, {
            method: "GET",
        })
        if (reponse.ok){
            const response = await reponse.json()
            if (response.manager_id.data){
                id_manager = response.manager_id.data;
                console.log("voici l'id  " + response.manager_id.data)
            }else {
                console.log("pas d'id manager")
            }
        }else {
            console.log(reponse.status)
            console.log("problème avec la récup de l'id du manager")
        }
        return id_manager;
    }

    return {
        search_id_manager,

    };
};

export default manager_token;