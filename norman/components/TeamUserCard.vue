<script>
export default {
  props: {
    name_user: String, // Propriété pour le nom de l'utilisateur
    status_user: Boolean, // Propriété pour le statut de l'utilisateur
  },
};
</script>

<template>

  <div class="card">
    <img src="../assets/images/user_profil.png" alt="image profil"/>
    <div class="name_presence">
      <h1>{{ name_user }}</h1>
      <p v-if="status_user">Présent</p>
      <p v-else class="abs">Absent</p>
    </div>
  </div>

</template>

<style scoped lang="scss">

img{
  width: 50px;
  height: 100%;
}
.card{
  display: flex;
  border-radius: 15px; /* Ajoutez le bord arrondi ici */
  border: 2px solid $black;
  width: fit-content;
  padding-right: 10px;
}
.name_presence{
  @include GT-America;
  color: $black;
  font-size: 11px;
  padding-top: 5px;
  padding-left: 15px;
}
p{
  color: #1e7e34;
}

p.abs{
  color: red;
}

</style>