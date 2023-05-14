#文字列リテラルをfreeze（破壊的変更を防止）させています。RSpecとは関係ありません。記述がなくても動作します。
# frozen_string_literal: true

#これはspec/rails_helper.rbを読み込んでいます。設定などを行うファイルです。
require 'rails_helper'

RSpec.describe Book, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      #FactoryBot.build(:book)で作成したBookモデルのインスタンスをexpectに渡して、be_validで有効かを判定しています。
      expect(FactoryBot.build(:book)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      book = Book.new(title: '', body:'hoge')
      expect(book).to be_invalid
      expect(book.errors[:title]).to include("can't be blank")
    end
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      book = Book.new(title: 'hoge', body:'')
      expect(book).to be_invalid
      #マッチャーのincludeは配列の中身に〇〇が含まれているかを判定します。今回の場合はexpectにエラーメッセージの配列を渡して、その配列の中に"can't be blank"という要素が含まれるかを判定しています。
      expect(book.errors[:body]).to include("can't be blank")
    end
  end
  feature "titleを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit books_path
      fill_in 'book[title]', with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "can't be blank"
    end
  end
  feature "bodyを空白で投稿した場合に画面にエラーメッセージが表示されているか" do
    before do
      visit books_path
      fill_in 'book[body]', with: ''
    end
    scenario "エラーメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "can't be blank"
    end
  end
  

end
