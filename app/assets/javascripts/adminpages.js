$(document).ready( function () {
  $('#admintable').DataTable({
    ajax: '/api/data/appointments',

    columns: [
      {title: 'User ID', data: 'user_id'},
      {title: 'Firstname', data: 'name'},
      {title: 'Rate', data: 'charge'},
      {title: 'Appointments Count', data: 'count'},
      {title: 'Revenue', data: 'total'}
    ]
  });
} );