import user from './user'

const workteams = () => {


    let url = "http://localhost:4000/api/workteams";
    async function createWorkTeams(team_name: string, manager_id: string, worker_id: string) {
        const wtData = {
            team_name: `${team_name}`,
            manager_id: `${manager_id}`,
            worker_id: `${worker_id}`
        }
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({workteams: wtData})
        })
        if (!response.ok){
            throw new Error(`Erreur HTTP! Statut: ${response.status}`);
        }else {
            console.log("workteam créer :)")
            const result = await response.json();
            return result.data;
        }
    }

    async function getWorkTeamsByManager(manager_id: string){
        url += `/${manager_id}`;
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`Erreur HTTP! Statut: ${response.status}`);
        }
        const result = await response.json();
        if (result && result.data) {
            console.log(result.data);
            return result.data;
        } else {
            console.log("Réponse inattendue:", result);
            return null;
        }
    }

    async function get_all_teams() {
        let tab_teams = [];
        const url = 'http://localhost:4000/api/workteams';
        try {
            const response = await fetch(url, {
                method: "GET"
            });
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const allTeams = await response.json();
            console.log(allTeams)
            tab_teams = await order_teams_by_user(allTeams)
            console.log(tab_teams)
            return allTeams;
        } catch (e) {
            console.error('Error fetching data: ', e);
        }
    }


    async function order_teams_by_user(all_teams: any){
        const data = all_teams.data

        let liste_teams = []

        let liste_complet_teams = [];

        for (let i = 0; i < data.length; i++){
            if (!liste_teams.includes(data[i].team_name)){
                liste_teams.push(data[i].team_name)
            }
        }
        for (let i = 0; i < liste_teams.length; i++){
            let team = {
                "manager": "",
                "team_name": liste_teams[i],
                'participant': [],
            }
            let user_complet = ""
            for (let j = 0; j < data.length; j++){
                if (team.manager === ""){
                    team.manager = await user().getUser(data[j].manager_id, "", "")
                }
                if (liste_teams[i] === data[j].team_name){
                    team.participant.push(user().getUser(data[j].worker_id, "", ""))
                }
            }

            liste_complet_teams.push(team);
        }
        return liste_complet_teams
    }


    return {
        get_all_teams,
        createWorkTeams,
        getWorkTeamsByManager
    };
};

export default workteams;