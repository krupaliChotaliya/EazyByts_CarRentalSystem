package com.car.rental.system.Model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.boot.autoconfigure.domain.EntityScan;


@Entity
@EntityScan
@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table(name="car")
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Id;
    @Column
    private String model;
    @Column
    private String year;
    private String type;
    private String capacity;
    private String price_per_day;
    private String location;
    private String color;
    private String brand;
    private String image;
}
