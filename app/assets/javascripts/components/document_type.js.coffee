@DocumentType = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.ajax
      method: 'DELETE'
      url: "/document_types/#{ @props.document_type.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteDocumentType @props.document_type
  handleEdit: (e) ->
    e.preventDefault()
    data =
      description: React.findDOMNode(@refs.description).value
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.ajax
      method: 'PUT'
      url: "/document_types/#{ @props.document_type.id }"
      dataType: 'JSON'
      data:
        document_type: data
      success: (data) =>
        @setState edit: false
        @props.handleEditDocumentType @props.document_type, data
  documentTypeRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.document_type.description
      React.DOM.td null, @props.document_type.account_type
      React.DOM.td null, @props.document_type.stock_type
      React.DOM.td null, if @props.document_type.stock then 'Yes' else 'No'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-mini'
          onClick: @handleToggle
          'Edit'
        ' '
        React.DOM.a
          className: 'btn btn-mini btn-danger'
          onClick: @handleDelete
          'Destroy'
  documentTypeForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.document_type.description
          ref: 'description'
      React.DOM.td null
      React.DOM.td null
      React.DOM.td null
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-mini btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-mini btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @documentTypeForm()
    else
      @documentTypeRow()
