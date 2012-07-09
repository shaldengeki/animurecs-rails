$("#list-entry-form").fadeOut("slow");
$("#user_feed").html("<%= escape_javascript(render(@list)) %>");
(function() {
    jQuery(function() {
        return $('#user_list').dataTable({
            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "sPaginationType": "bootstrap",
            "aaSorting": [[1, 'asc'], [0, 'asc']],
            "oLanguage": {"sEmptyTable": "This user has no entries in their list.", "sZeroRecords": "No entries matched your filter."}
        });
    });
}).call(this);