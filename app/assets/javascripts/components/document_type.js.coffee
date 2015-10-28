@DocumentType = React.createClass
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
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.document_type.description
      React.DOM.td null, @props.document_type.account_type
      React.DOM.td null, @props.document_type.stock_type
      React.DOM.td null, @props.document_type.stock
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-mini btn-danger'
          onClick: @handleDelete
          'Destroy'
