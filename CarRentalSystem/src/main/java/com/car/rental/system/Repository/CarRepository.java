package com.car.rental.system.Repository;

import com.car.rental.system.Model.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CarRepository extends JpaRepository<Car,Integer> {

    @Query(value = "SELECT * FROM Car WHERE user_user_id = :userId", nativeQuery = true)
    List<Car> getAllCarsByUserId(int  userId);

    @Query(value = "SELECT b.* FROM Car b INNER JOIN users u ON b.user_user_id = u.user_id INNER JOIN category c ON b.category_id_id = c.id WHERE b.content LIKE %:keyword% OR b.title LIKE %:keyword% OR u.username LIKE %:keyword% OR c.name LIKE %:keyword%",nativeQuery = true )
    List<Car> findByTitleContainingOrContentContaining(String keyword);
}