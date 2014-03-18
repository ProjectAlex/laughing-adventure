require 'spec_helper'

describe Post do
    it "Tests for posts" do
        prashant = Post.create!(:content => "abcd",:caption => "defg")
        mithul = Post.create!(:content => "bcde",:caption => "efgh")
        expect(Post.order_by_content).to eq([prashant,mithul])
    end
end
