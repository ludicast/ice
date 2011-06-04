describe "Form Builder Tags", ->
  describe "labelTag", ->
    it "assigns default value", ->
      tag = labelTag('name')
      (expect tag).toEqual '<label for="name">Name</label>'

    it "assigns humanized default value", ->
      tag = labelTag 'supervising_boss_id'
      (expect tag).toEqual '<label for="supervising_boss_id">Supervising boss</label>'

    it "allows alternative value", ->
      tag = labelTag 'name', 'Your Name'
      (expect tag).toEqual '<label for="name">Your Name</label>'

    it "allows class to be assigned", ->
      tag = labelTag 'name', 'class':'small_label'
      (expect tag).toEqual '<label class="small_label" for="name">Name</label>'

  describe "for passwordFieldTag", ->
    it "should generate regular password tag", ->
      tag = passwordFieldTag('pass')
      (expect tag).toEqual '<input id="pass" name="pass" type="password" />'

    it "should have alternate value", ->
      tag = passwordFieldTag('secret', 'Your secret here')
      (expect tag).toEqual '<input id="secret" name="secret" type="password" value="Your secret here" />'

    it "should take class", ->
      tag = passwordFieldTag('masked', {'class':'masked_input_field'})
      (expect tag).toEqual '<input class="masked_input_field" id="masked" name="masked" type="password" />'

    it "should take size", ->
      tag = passwordFieldTag('token','', {size:15})
      (expect tag).toEqual '<input id="token" name="token" size="15" type="password" value="" />'

    it "should take maxlength", ->
      tag = passwordFieldTag('key',{maxlength:16})
      (expect tag).toEqual '<input id="key" maxlength="16" name="key" type="password" />'

    it "should take disabled option", ->
      tag = passwordFieldTag('confirm_pass',{disabled:true})
      (expect tag).toEqual '<input disabled="disabled" id="confirm_pass" name="confirm_pass" type="password" />'

    it "should take multiple options", ->
      tag = passwordFieldTag('pin','1234',{maxlength:4,size:6, 'class':'pin-input'})
      (expect tag).toEqual '<input class="pin-input" id="pin" maxlength="4" name="pin" size="6" type="password" value="1234" />'

  describe "for checkBoxTag", ->

    it "should generate basic checkbox", ->
      tag = checkBoxTag('accept')
      (expect tag).toEqual '<input id="accept" name="accept" type="checkbox" value="1" />'

    it "should take alternate values", ->
      tag = checkBoxTag('rock', 'rock music')
      (expect tag).toEqual '<input id="rock" name="rock" type="checkbox" value="rock music" />'

    it "should take parameter for checked", ->
      tag = checkBoxTag('receive_email', 'yes', true)
      (expect tag).toEqual '<input checked="checked" id="receive_email" name="receive_email" type="checkbox" value="yes" />'
