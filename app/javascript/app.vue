<template>
  <div id="app">
    <!-- フォームの送信 -->
    <div class="form">
      <div class="form-group">
        <input type="text" class="form-control" v-model="title" placeholder="title">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="description" placeholder="description">
      </div>
      <button @click="addMemo()">メモを追加</button>
    </div>
    <!-- memosを表示する -->
    <div class="flex">
      <div v-for="memo in memos" :key="memo.id" class="card">
        <div class="card-body">
          <div class="card-title">
            {{memo.title}}
          </div>
          {{memo.description}}
        </div>
      </div>
    </div>
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

<style lang="scss" scoped>
  .form {
   display: flex;
   flex-direction: column;
   justify-content: center;
   align-items: center;
   margin: 32px;
   &-group {
     margin-bottom: 1rem;
   }
   &-control {
     width: 600px;
     min-height: 24px;
     font-size: 1rem;
     border: 1px solid #ced4da;
     padding: 4px 8px;
   }
  }

  button {
    width: 200px;
  }

  .flex {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }

  .card {
    width: 238px;
    border: 1px solid rgba(0,0,0,.125);
    border-radius: .25rem;
    margin: 16px;
    &-body {
      padding: 1.25rem;
    }
    &-title {
      margin-bottom: .75rem;
      font-weight: 600;
    }
  }
</style>
