package azelha.karimerri.controllers;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import azelha.karimerri.entites.Item;
import azelha.karimerri.entites.OperationResponse;
import azelha.karimerri.entites.OperationResponse.ResponseStatusEnum;
import azelha.karimerri.services.ItemService;

@CrossOrigin(origins = { "http://10.0.2.2" })
@RestController
public class ItemController {

	@Autowired
	protected ItemService orderItemService;

	@PostMapping(path = "/orderItems/new", consumes = "application/json")
	public OperationResponse createOrder(@RequestBody Set<Item> orderItems) {

		final OperationResponse resp = new OperationResponse();

		final Set<Item> persistedOrderItem = orderItemService.createOrderItem(orderItems);
		if (persistedOrderItem == null) {
			resp.setOperationStatus(ResponseStatusEnum.ERROR);
			resp.setOperationMessage("Unable to add OrderItem - OrderItem allready exist ");
		} else {

			resp.setOperationStatus(ResponseStatusEnum.SUCCESS);
			resp.setOperationMessage("Created new product with id : {} and name : {}" + persistedOrderItem.size()
					+ "info OrderItem created successfully");
		}

		return resp;
	}

	@GetMapping(path = "/orderItems/product/{id}")
	public Item getOrderItemByProductId(@PathVariable Integer id) {

		// System.out.println(orderItemService.getOrderItemByProductId(id).getItemName());
		return orderItemService.getOrderItemByProductId(id);
	}

	@GetMapping(path = "/orderItems")
	public List<Item> listOrderItems() {
		return orderItemService.getAllOrderItems();
	}
}
