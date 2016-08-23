require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe LiquidPartialsController, type: :controller do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # LiquidPartial. As you add validations to LiquidPartial, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for :liquid_partial
  end

  let(:invalid_attributes) do
    attributes_for :liquid_partial, title: ' '
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LiquidPartialsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all liquid_partials as @liquid_partials" do
      liquid_partial = LiquidPartial.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:liquid_partials)).to eq([liquid_partial])
    end
  end

  describe "GET #show" do
    it "is not a route" do
      liquid_partial = LiquidPartial.create! valid_attributes
      expect do
        get :show, {:id => liquid_partial.to_param}
      end.to raise_error ActionController::UrlGenerationError
    end
  end

  describe "GET #new" do
    it "assigns a new liquid_partial as @liquid_partial" do
      get :new, {}, valid_session
      expect(assigns(:liquid_partial)).to be_a_new(LiquidPartial)
    end
  end

  describe "GET #edit" do
    it "assigns the requested liquid_partial as @liquid_partial" do
      liquid_partial = LiquidPartial.create! valid_attributes
      get :edit, {:id => liquid_partial.to_param}, valid_session
      expect(assigns(:liquid_partial)).to eq(liquid_partial)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new LiquidPartial" do
        expect do
          post :create, {:liquid_partial => valid_attributes}, valid_session
        end.to change(LiquidPartial, :count).by(1)
      end

      it "assigns a newly created liquid_partial as @liquid_partial" do
        post :create, {:liquid_partial => valid_attributes}, valid_session
        expect(assigns(:liquid_partial)).to be_a(LiquidPartial)
        expect(assigns(:liquid_partial)).to be_persisted
      end

      it "redirects to the created liquid_partial's edit page" do
        post :create, {:liquid_partial => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_liquid_partial_path(LiquidPartial.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved liquid_partial as @liquid_partial" do
        post :create, {:liquid_partial => invalid_attributes}, valid_session
        expect(assigns(:liquid_partial)).to be_a_new(LiquidPartial)
      end

      it "re-renders the 'new' template" do
        post :create, {:liquid_partial => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        attributes_for :liquid_partial
      end

      it "updates the requested liquid_partial" do
        liquid_partial = LiquidPartial.create! valid_attributes
        put :update, {:id => liquid_partial.to_param, :liquid_partial => new_attributes}, valid_session
        liquid_partial.reload
        expect(liquid_partial.title).not_to eq valid_attributes[:title]
        expect(liquid_partial.title).to eq new_attributes[:title]
      end

      it "assigns the requested liquid_partial as @liquid_partial" do
        liquid_partial = LiquidPartial.create! valid_attributes
        put :update, {:id => liquid_partial.to_param, :liquid_partial => valid_attributes}, valid_session
        expect(assigns(:liquid_partial)).to eq(liquid_partial)
      end

      it "redirects to the liquid_partial's edit page" do
        liquid_partial = LiquidPartial.create! valid_attributes
        put :update, {:id => liquid_partial.to_param, :liquid_partial => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_liquid_partial_path(liquid_partial))
      end
    end

    context "with invalid params" do
      it "assigns the liquid_partial as @liquid_partial" do
        liquid_partial = LiquidPartial.create! valid_attributes
        put :update, {:id => liquid_partial.to_param, :liquid_partial => invalid_attributes}, valid_session
        expect(assigns(:liquid_partial)).to eq(liquid_partial)
      end

      it "re-renders the 'edit' template" do
        liquid_partial = LiquidPartial.create! valid_attributes
        put :update, {:id => liquid_partial.to_param, :liquid_partial => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested liquid_partial" do
      liquid_partial = LiquidPartial.create! valid_attributes
      expect do
        delete :destroy, {:id => liquid_partial.to_param}, valid_session
      end.to change(LiquidPartial, :count).by(-1)
    end

    it "redirects to the liquid_partials list" do
      liquid_partial = LiquidPartial.create! valid_attributes
      delete :destroy, {:id => liquid_partial.to_param}, valid_session
      expect(response).to redirect_to(liquid_partials_url)
    end
  end

end
