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

    return {
        createWorkTeams,
        getWorkTeamsByManager
    };
};

export default workteams;