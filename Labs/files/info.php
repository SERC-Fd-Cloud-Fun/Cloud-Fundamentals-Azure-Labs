<?php
// =====================================================================
// Lab 4 – VM Information Dashboard
//
// Before uploading this file, replace the placeholders below with your
// actual database VM private IP address and the password you set in
// Exercise 2 of the lab.
// =====================================================================

define('DB_HOST',     '<database-vm-private-ip>');  // private IP of your DB VM
define('DB_USER',     'lab4user');
define('DB_PASSWORD', '<your-database-password>');  // password set in Exercise 2
define('DB_NAME',     'lab4app');

// ---- Azure Instance Metadata Service (IMDS) -------------------------

/**
 * Fetch VM metadata from the Azure IMDS endpoint.
 * Returns a decoded associative array, or an empty array on failure.
 */
function get_vm_metadata(): array {
    $opts = [
        'http' => [
            'method'  => 'GET',
            'header'  => "Metadata: true\r\n",
            'timeout' => 2,
        ],
    ];
    $ctx  = stream_context_create($opts);
    $url  = 'http://169.254.169.254/metadata/instance?api-version=2021-02-01&format=json';
    $json = @file_get_contents($url, false, $ctx);
    if ($json === false) {
        return [];
    }
    $data = json_decode($json, true);
    return is_array($data) ? $data : [];
}

$meta    = get_vm_metadata();
$compute = $meta['compute'] ?? [];

// ---- MySQL connection test -------------------------------------------

$db_status  = '';
$db_class   = '';
$db_version = '';

$placeholders_set = (DB_HOST === '<database-vm-private-ip>' || DB_PASSWORD === '<your-database-password>');

if ($placeholders_set) {
    $db_status = 'Skipped – replace DB_HOST and DB_PASSWORD at the top of this file.';
    $db_class  = 'warning';
} else {
    $conn = @new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    if ($conn->connect_error) {
        $db_status = 'Connection failed: ' . $conn->connect_error;
        $db_class  = 'fail';
    } else {
        $db_status  = 'Connected successfully';
        $db_class   = 'ok';
        $result     = $conn->query('SELECT VERSION() AS ver');
        if ($result) {
            $db_version = $result->fetch_assoc()['ver'] ?? '';
        }
        $conn->close();
    }
}

// ---- Helper ----------------------------------------------------------

function h(string $value): string {
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function row(string $label, string $value, bool $raw = false): void {
    if ($raw) {
        $cell = $value;
    } elseif ($value === '') {
        $cell = '<td><span class="empty">unavailable</span></td>';
    } else {
        $cell = '<td>' . h($value) . '</td>';
    }
    echo "<tr><th>" . h($label) . "</th>$cell</tr>\n";
}

?><!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Lab 4 – VM Info</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: system-ui, -apple-system, sans-serif;
      background: #f4f7fb;
      color: #1a1a2e;
      padding: 2rem;
      max-width: 860px;
      margin: 0 auto;
    }

    h1 { margin-bottom: 1.5rem; font-size: 1.6rem; }

    h2 {
      margin: 1.75rem 0 .75rem;
      font-size: .8rem;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: .1em;
      color: #666;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 1px 4px rgba(0,0,0,.08);
    }

    th, td {
      padding: .65rem 1rem;
      text-align: left;
      border-bottom: 1px solid #eee;
      font-size: .9rem;
      vertical-align: top;
    }

    th {
      width: 38%;
      background: #f0f2f8;
      font-weight: 600;
    }

    tr:last-child td,
    tr:last-child th { border-bottom: none; }

    .empty { color: #aaa; font-style: italic; }

    .badge {
      display: inline-block;
      padding: .2rem .7rem;
      border-radius: 1rem;
      font-weight: 600;
      font-size: .85rem;
    }

    .badge.ok      { background: #d4edda; color: #155724; }
    .badge.fail    { background: #f8d7da; color: #721c24; }
    .badge.warning { background: #fff3cd; color: #856404; }
  </style>
</head>
<body>

  <h1>Lab 4 – VM Information Dashboard</h1>

  <h2>Web Server VM</h2>
  <table>
    <?php
    row('Hostname',       gethostname());
    row('VM Name',        $compute['name']             ?? '');
    row('VM Size',        $compute['vmSize']           ?? '');
    row('Location',       $compute['location']         ?? '');

    $offer = $compute['storageProfile']['imageReference']['offer'] ?? '';
    $sku   = $compute['storageProfile']['imageReference']['sku']   ?? '';
    row('OS Image',       trim("$offer $sku"));

    row('Subscription ID', $compute['subscriptionId']  ?? '');
    row('Resource Group', $compute['resourceGroupName'] ?? '');
    row('PHP Version',    phpversion());
    ?>
  </table>

  <h2>Database Connection</h2>
  <table>
    <?php
    row('Host',     DB_HOST);
    row('Database', DB_NAME);
    row('User',     DB_USER);
    ?>
    <tr>
      <th>Status</th>
      <td><span class="badge <?= h($db_class) ?>"><?= h($db_status) ?></span></td>
    </tr>
    <?php if ($db_version !== ''): ?>
    <tr>
      <th>MySQL Version</th>
      <td><?= h($db_version) ?></td>
    </tr>
    <?php endif; ?>
  </table>

</body>
</html>
