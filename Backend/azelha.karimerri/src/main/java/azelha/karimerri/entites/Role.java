package azelha.karimerri.entites;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@Entity
@Table(name = "roles")
@JsonIgnoreProperties(value = "hibernateLazyInitializer")
public class Role {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	@Column(nullable = false, unique = true)

	private String name;

	@Column(length = 1024)
	private String description;

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "roles")
	private Set<User> users = new HashSet<User>();;

	@JsonIgnore
	@OneToMany(cascade = CascadeType.PERSIST, mappedBy = "role")
	private Set<Permission> permissions = new HashSet<Permission>();

	Role() {
	}

	public Role(String name) {
		this.name = name;
	}

}
