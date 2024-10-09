# frozen_string_literal: true

class ReactAppController < ApplicationController
  layout "hello_world"

  def index
    @props = { name: "Stranger" }
  end
end
