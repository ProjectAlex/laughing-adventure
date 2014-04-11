<div id="add-email" class="container">
  ## Add Email
  <%= form_for(@user, :as => 'user', :url => add_user_email_path(@user), :html => { role: 'form'}) do |f| %>
    <% if @show_errors && @user.errors.any? %>
      <div id="error_explanation">
        <% @user.errors.full_messages.each do |msg| %>
          <%= msg %><br>
        <% end %>
      </div>
    <% end %>
    <div class="form-group">
      <%= f.label :email %>
      <div class="controls">
        <%= f.text_field :email, :autofocus => true, :value => '', class: 'form-control input-lg', placeholder: 'Example: email@me.com' %>
        <p class="help-block">Please confirm your email address. No spam.</p>
      </div>
    </div>
    <div class="actions">
      <%= f.submit 'Continue', :class => 'btn btn-primary' %>
    </div>
  <% end %>
</div>
