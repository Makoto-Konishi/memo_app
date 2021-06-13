<template>
  <div id="app">
    <!-- memosを表示する -->
    <ul>
      <li v-for="memo in memos" :key="memo.id">
        title:{{memo.title}}, description{{memo.description}}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      memos: []
    }
  },
  // アプリが立ち上がった最初のタイミングで実行される関数を定義
  mounted(){
    this.setMemo();
  },
  // axiosでapi/memosのAPIを呼び出す
  methods: {
    setMemo: function(){
      axios.get('/api/memos')
      .then( response => {
        this.memos = response.data;
      })
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
