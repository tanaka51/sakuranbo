# -*- coding: utf-8 -*-
require 'spec_helper'

describe Sakuranbo do
  let(:source) {
    <<-EOF
    class User
      has_many :comments, lazy_update: #{lazy_update_option rescue "true"}
    end
    EOF
  }

  it "enables 'lazy_update' option to ActiveRecord::Base#has_many" do
    expect { eval(source) }.to_not raise_error
  end

  describe "lazy_update usage:" do
    subject { User.new }
    before  { eval source }

    shared_examples_for "update lazy" do |prefix|
      it "defines attr_accessor :#{prefix}_comment_ids" do
        expect(subject.respond_to?("#{prefix}_comment_ids" .to_sym)).to be_true
        expect(subject.respond_to?("#{prefix}_comment_ids=".to_sym)).to be_true
      end

      it "assings #{prefix}_comment_ids to comment_ids in before_save when update" do
        subject.save!
        c = Comment.create(body: 'foo')

        subject.send("#{prefix}_comment_ids=", [c.id])
        expect(subject.comment_ids).to be_empty

        subject.valid?
        expect(subject.comment_ids).to be_empty

        subject.save!
        expect(subject.comment_ids).to eq [c.id]
      end
    end

    context "`has_many :comments, lazy_update: true`" do
      let!(:lazy_update_option) { "true" }

      it_should_behave_like "update lazy", "cached"
    end

    context "`has_many :comments, lazy_update: :my_prefix`" do
      let!(:lazy_update_option) { ":my_prefix" }

      it_should_behave_like "update lazy", "my_prefix"
    end

  end
end
