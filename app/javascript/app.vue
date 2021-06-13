<template>
  <div id="app">
    <!-- memosを表示する -->
    <ul>
      <li v-for="memo in memos" :key="memo.id">
        title:{{memo.title}}, description{{memo.description}}
      </li>
    </ul>
    <!-- v-model dataオプションの中で該当するプロパティを自動的に更新 -->
    <input type="text" v-model="title" placeholder="title">
    <input type="text" v-model="description" placeholder="description">
    <!-- 投稿ボタンをクリックしたら、フォームに入力した内容をAxiosを使ってPOST送信 -->
    <button @click="addMemo()">メモを追加</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      memos: [],
      title: "",
      description: ""
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
    },
    addMemo: function(){
      axios.post('/api/memos', {
        title: this.title,
        description: this.description
      })
      .then( response => {
        // POST送信が成功したら、setMemo()関数を呼び出し、投稿した情報を画面に表示
        this.setMemo();
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
