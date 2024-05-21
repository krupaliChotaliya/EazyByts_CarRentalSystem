package com.car.rental.system.Model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import java.util.Date;

@Entity
@EntityScan
@Builder
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table(name="rental")
public class Rental {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "userId")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "car_id", referencedColumnName = "Id")
    private Car car;
    @Column
    private Date start_date;
    @Column
    private Date end_date;
    @Column
    private String payment;
    @Column
    private String payment_status;

}
