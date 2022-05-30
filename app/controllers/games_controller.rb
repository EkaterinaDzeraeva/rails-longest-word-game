require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  # def correct_word?
  #   url = "https://wagon-dictionary.herokuapp.com/#{answer}"
  #   dictionary = open(url).read
  #   word = JSON.parse(dictionary)
  #   word['found']
  #   raise
  # end

  # def includes?
  #   @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  # end

  def score
    @answer = params[:word]
    @grid = params[:grid]
    if !correct_word?
      @output = "The word is not a valid English word!"
    elsif !includes?
      @output = "The word can't be built out of the original grid"
    elsif includes? && !correct_word?
      @output = "The word is not a valid English word!"
    elsif includes? && correct_word?
      @output = "Yaaay! You rock! This is a valid English word"
    end
  end

  private

  def correct_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary = URI.open(url).read
    word = JSON.parse(dictionary)
    word['found']
    # raise
  end

  def includes?
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end
end
