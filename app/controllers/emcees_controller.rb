class EmceesController < ApplicationController
  before_action :set_emcee, only: [:show, :edit, :update, :destroy]

  # GET /emcees
  # GET /emcees.json
  def index
    @emcees = Emcee.all
  end

  # GET /emcees/1
  # GET /emcees/1.json
  def show
  end

  # GET /emcees/new
  def new
    @emcee = Emcee.new
  end

  # GET /emcees/1/edit
  def edit
  end

  # POST /emcees
  # POST /emcees.json
  def create
    @emcee = Emcee.new(emcee_params)
    respond_to do |format|
      if @emcee.save
        format.html { redirect_to @emcee, notice: 'Emcee was successfully created.' }
        format.json { render :show, status: :created, location: @emcee }
      else
        format.html { render :new }
        format.json { render json: @emcee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emcees/1
  # PATCH/PUT /emcees/1.json
  def update
    respond_to do |format|
      if @emcee.update(emcee_params)
        format.html { redirect_to @emcee, notice: 'Emcee was successfully updated.' }
        format.json { render :show, status: :ok, location: @emcee }
      else
        format.html { render :edit }
        format.json { render json: @emcee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emcees/1
  # DELETE /emcees/1.json
  def destroy
    @emcee.destroy
    respond_to do |format|
      format.html { redirect_to emcees_url, notice: 'Emcee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_emcee
      @emcee = Emcee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emcee_params
      params.require(:emcee).permit(:name, :email, :password, :password_confirmation)
    end
end

