describe "Form Builder Tags", ->
  describe "label_tag", ->
    it "assigns default value", ->
      tag = label_tag('name')
      (expect tag).toEqual '<label for="name">Name</label>'

    it "assigns humanized default value", ->
      tag = label_tag 'supervising_boss_id'
      (expect tag).toEqual '<label for="supervising_boss_id">Supervising boss</label>'

    it "allows alternative value", ->
      tag = label_tag 'name', 'Your Name'
      (expect tag).toEqual '<label for="name">Your Name</label>'

    it "allows class to be assigned", ->
      tag = label_tag 'name', 'class':'small_label'
      (expect tag).toEqual '<label class="small_label" for="name">Name</label>'

  describe "for password_field_tag", ->
    it "should generate regular password tag", ->
      tag = password_field_tag('pass')
      (expect tag).toEqual '<input id="pass" name="pass" type="password" />'

    it "should have alternate value", ->
      tag = password_field_tag('secret', 'Your secret here')
      (expect tag).toEqual '<input id="secret" name="secret" type="password" value="Your secret here" />'

    it "should take class", ->
      tag = password_field_tag('masked', {'class':'masked_input_field'})
      (expect tag).toEqual '<input class="masked_input_field" id="masked" name="masked" type="password" />'

    it "should take size", ->
      tag = password_field_tag('token','', {size:15})
      (expect tag).toEqual '<input id="token" name="token" size="15" type="password" value="" />'

    it "should take maxlength", ->
      tag = password_field_tag('key',{maxlength:16})
      (expect tag).toEqual '<input id="key" maxlength="16" name="key" type="password" />'

    it "should take disabled option", ->
      tag = password_field_tag('confirm_pass',{disabled:true})
      (expect tag).toEqual '<input disabled="disabled" id="confirm_pass" name="confirm_pass" type="password" />'

    it "should take multiple options", ->
      tag = password_field_tag('pin','1234',{maxlength:4,size:6, 'class':'pin-input'})
      (expect tag).toEqual '<input class="pin-input" id="pin" maxlength="4" name="pin" size="6" type="password" value="1234" />'

  describe "for check_box_tag", ->

    it "should generate basic checkbox", ->
      tag = check_box_tag('accept')
      (expect tag).toEqual '<input id="accept" name="accept" type="checkbox" value="1" />'

    it "should take alternate values", ->
      tag = check_box_tag('rock', 'rock music')
      (expect tag).toEqual '<input id="rock" name="rock" type="checkbox" value="rock music" />'

    it "should take parameter for checked", ->
      tag = check_box_tag('receive_email', 'yes', true)
      (expect tag).toEqual '<input checked="checked" id="receive_email" name="receive_email" type="checkbox" value="yes" />'
