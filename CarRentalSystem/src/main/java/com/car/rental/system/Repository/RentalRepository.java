package com.car.rental.system.Repository;

import com.car.rental.system.Model.Rental;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RentalRepository extends JpaRepository<Rental,Integer> {

    @Query(value = "SELECT * FROM Rental WHERE user_user_id = :userId", nativeQuery = true)
    List<Rental> getAllRentalsByUserId(int  userId);
}