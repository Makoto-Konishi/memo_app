class Api::MemosController < ApplicationController
  def index 
    @memos = Memo.order('created_at DESC')
  end

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      # 201 Created, リクエストが成功してリソースの作成が完了したことを表す
      render :show, status: 201
    else
      # 422 Unprocessable Entity, サーバーが要求本文のコンテンツ型を理解でき、要求本文の構文は正しいものの、中に含まれている指示が処理できなかったことを表す
      render json: @memo.errors, status: 422
    end
  end

  private

  def memo_params
    params.permit(:title, :description)
  end
end
