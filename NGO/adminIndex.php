<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-lg p-3 mb-5 ">
  <a class="navbar-brand" href="index.php">NGO</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="index.php" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="#">Admin<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item ">
        <a class="nav-link" href="logout.php">
        <?php 
          $stmt3 = $pdo->query("SELECT `name` FROM `admin` WHERE `admin_id` =".$_SESSION['admin_id']);
          $rows2 = $stmt3->fetchAll(PDO::FETCH_ASSOC);
          echo $rows2[0]['name'];
        ?>
        <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item ">
        <a class="nav-link" href="update/adminUpdate.php">Edit Profile<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item ">
        <a class="nav-link" href="adminVolunteer.php">Volunteers<span class="sr-only">(current)</span></a>
      </li>      
      <li class="nav-item ">
        <a class="nav-link" href="logout.php">Logout<span class="sr-only">(current)</span></a>
      </li>
    </ul>
  </div>
</nav>

<div>
    <?php 
    // Get overall total donations
    $stmt = $pdo->query("SELECT SUM(donationS) as total FROM ngo_account");
    $total = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "<h2 class='shadow-lg p-3 mb-5 bg-light rounded mx-auto' style='width: 550px;'>
          The Overall Donations Are $ ".$total['total']."</h2>";

    // Get all cities with their donation statistics
    $stmt = $pdo->query("SELECT 
        c.city_id,
        c.cname,
        SUM(na.donationS) as total_donation,
        MAX(na.donationS) as highest_donation
        FROM city c
        LEFT JOIN ngo_account na ON c.city_id = na.city_id
        GROUP BY c.city_id, c.cname
        ORDER BY c.city_id");
    $cities = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Display cities in pairs
    for($i = 0; $i < count($cities); $i += 2) {
        echo '<div class="row">';
        
        // Display two cities per row
        for($j = $i; $j < min($i + 2, count($cities)); $j++) {
            $city = $cities[$j];
            
            echo '<div class="col-6">
                <h3>'.htmlentities($city['cname']).' Donors</h3>
                <div class="mb-3 shadow-lg p-3 bg-light rounded">
                    <strong>Total Donations: </strong>$ '.($city['total_donation'] ?? 0).'<br>
                    <strong>Highest Donation: </strong>$ '.($city['highest_donation'] ?? 0).'
                </div>
                <table class="table shadow-lg p-3 mb-5 bg-light rounded">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Sno</th>
                            <th scope="col">Donor Name</th>
                            <th scope="col">Donation</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>';
                    
            // Get donors list for current city
            $stmt = $pdo->prepare("SELECT na.donor_id, d.name, na.donationS 
                                  FROM donor d 
                                  JOIN ngo_account na ON d.donor_id = na.donor_id 
                                  WHERE na.city_id = ?
                                  ORDER BY na.donationS DESC");
            $stmt->execute([$city['city_id']]);
            $donors = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            $count = 1;
            foreach($donors as $donor) {
                echo "<tr>
                        <th scope='row'>".$count."</th>
                        <td>".htmlentities($donor['name'])."</td>
                        <td>$ ".htmlentities($donor['donationS'])."</td>
                        <td><a class='btn btn-primary btn-sm' href='admin/delete.php?donor_id=".$donor['donor_id']."'>Remove Donor</a></td>
                      </tr>";
                $count++;
            }
                    
            echo '</tbody>
                </table>
            </div>';
        }
        echo '</div>';
    }
    ?>
</div>
</div>    
