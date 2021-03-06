class Instituicao < ApplicationRecord

	before_create :add_token

	has_many :telefones, :dependent => :destroy
	has_many :enderecos, :dependent => :destroy
	has_many :users
	has_many :cadastros

	accepts_nested_attributes_for :telefones,  allow_destroy: true
	accepts_nested_attributes_for :enderecos, reject_if: :all_blank, allow_destroy: true

	validates_presence_of :nome_instituicao, :nome_relatorio_instituicao, :codigo_instituicao
	validates_length_of :nome_relatorio_instituicao, :maximum => 20, :minimum => 20

	def self.find_token_instituicao(token)
    	if (Instituicao.find_by token: token) != nil
    		return true
    	end

    	return false
  	end
	
	private

	def add_token
		begin
		  self.token = SecureRandom.hex[0,10].upcase
		end while self.class.exists?(token: token)
	end 

end