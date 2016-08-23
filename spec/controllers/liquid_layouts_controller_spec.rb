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

describe LiquidLayoutsController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # LiquidLayout. As you add validations to LiquidLayout, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:liquid_layout)
  end

  let(:invalid_attributes) do
    attributes_for(:liquid_layout, title: "")
  end
  let(:user) { create(:user) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LiquidLayoutsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all liquid_layouts as @liquid_layouts" do
      liquid_layout = LiquidLayout.create! valid_attributes
      get :index, {}
      expect(assigns(:liquid_layouts)).to eq([liquid_layout])
    end
  end

  describe "GET #show" do
    it "is not a route" do
      liquid_layout = LiquidLayout.create! valid_attributes
      expect do
        get :show, :id => liquid_layout.to_param
      end.to raise_error ActionController::UrlGenerationError
    end
  end

  describe "GET #new" do
    it "assigns a new liquid_layout as @liquid_layout" do
      get :new, {}
      expect(assigns(:liquid_layout)).to be_a_new(LiquidLayout)
    end
  end

  describe "GET #edit" do
    it "assigns the requested liquid_layout as @liquid_layout" do
      liquid_layout = LiquidLayout.create! valid_attributes
      get :edit, :id => liquid_layout.to_param
      expect(assigns(:liquid_layout)).to eq(liquid_layout)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new LiquidLayout" do
        expect do
          post :create, :liquid_layout => valid_attributes
        end.to change(LiquidLayout, :count).by(1)
      end

      it "assigns a newly created liquid_layout as @liquid_layout" do
        post :create, :liquid_layout => valid_attributes
        expect(assigns(:liquid_layout)).to be_a(LiquidLayout)
        expect(assigns(:liquid_layout)).to be_persisted
      end

      it "redirects to the edit page for the created liquid_layout" do
        post :create, :liquid_layout => valid_attributes
        expect(response).to redirect_to(edit_liquid_layout_path(LiquidLayout.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved liquid_layout as @liquid_layout" do
        post :create, :liquid_layout => invalid_attributes
        expect(assigns(:liquid_layout)).to be_a_new(LiquidLayout)
      end

      it "re-renders the 'new' template" do
        post :create, :liquid_layout => invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        attributes_for(:liquid_layout)
      end

      it "updates the requested liquid_layout" do
        liquid_layout = LiquidLayout.create! valid_attributes
        put :update, :id => liquid_layout.to_param, :liquid_layout => new_attributes
        liquid_layout.reload
        expect(liquid_layout.title).not_to eq valid_attributes[:title]
        expect(liquid_layout.title).to eq new_attributes[:title]
      end

      it "assigns the requested liquid_layout as @liquid_layout" do
        liquid_layout = LiquidLayout.create! valid_attributes
        put :update, :id => liquid_layout.to_param, :liquid_layout => valid_attributes
        expect(assigns(:liquid_layout)).to eq(liquid_layout)
      end

      it "redirects to the liquid_layout's edit page" do
        liquid_layout = LiquidLayout.create! valid_attributes
        put :update, :id => liquid_layout.to_param, :liquid_layout => valid_attributes
        expect(response).to redirect_to(edit_liquid_layout_path(liquid_layout))
      end
    end

    context "with invalid params" do
      it "assigns the liquid_layout as @liquid_layout" do
        liquid_layout = LiquidLayout.create! valid_attributes
        put :update, :id => liquid_layout.to_param, :liquid_layout => invalid_attributes
        expect(assigns(:liquid_layout)).to eq(liquid_layout)
      end

      it "re-renders the 'edit' template" do
        liquid_layout = LiquidLayout.create! valid_attributes
        put :update, :id => liquid_layout.to_param, :liquid_layout => invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested liquid_layout" do
      liquid_layout = LiquidLayout.create! valid_attributes
      expect do
        delete :destroy, :id => liquid_layout.to_param
      end.to change(LiquidLayout, :count).by(-1)
    end

    it "redirects to the liquid_layouts list" do
      liquid_layout = LiquidLayout.create! valid_attributes
      delete :destroy, :id => liquid_layout.to_param
      expect(response).to redirect_to(liquid_layouts_url)
    end
  end
end
