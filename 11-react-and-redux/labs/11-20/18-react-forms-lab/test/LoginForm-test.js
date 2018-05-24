import React from "react";
import { expect } from "chai";
import sinon from "sinon";
import { shallow } from "enzyme";

import LoginForm from "../src/components/LoginForm";
import { isValueInState, noop } from "./util";

describe("<LoginForm />", () => {
  const spy = sinon.spy();

  afterEach(() => {
    spy.reset();
  });

  describe("Saving input values in state", () => {
    it("should save the username in state when the input changes", () => {
      const wrapper = shallow(<LoginForm />);
      wrapper.find("#test-username").simulate("change", {
        target: { name: "username", id: "test-username", value: "johndoe" },
      });
      expect(
        isValueInState(wrapper.state(), "johndoe"),
        "The username input value is not being saved in the state"
      ).to.be.true;
    });

    it("should save the password in state when the input changes", () => {
      const wrapper = shallow(<LoginForm />);
      wrapper.find("#test-password").simulate("change", {
        target: {
          name: "password",
          id: "test-password",
          value: "supersecret",
        },
      });
      expect(
        isValueInState(wrapper.state(), "supersecret"),
        "The password input value is not being saved in the state"
      ).to.be.true;
    });
  });

  describe("Calling `onSubmit` callback prop", () => {
    it("should call the prevent the default action when the form is being submitted", () => {
      const wrapper = shallow(<LoginForm />);
      wrapper.find("form").simulate("submit", { preventDefault: spy });
      expect(
        spy.calledOnce,
        "The default form action is not being prevented when the form is submitted"
      ).to.be.true;
    });

    it("should not call the `onSubmit` callback prop when the username and/or password fields are empty", () => {
      const wrapper = shallow(<LoginForm onSubmit={spy} />);

      wrapper.find("#test-username").simulate("change", {
        target: { name: "username", id: "test-username", value: "" },
      });
      wrapper.find("#test-password").simulate("change", {
        target: {
          name: "password",
          id: "test-password",
          value: "supersecret",
        },
      });
      wrapper.find("form").simulate("submit", { preventDefault: noop });
      expect(
        spy.called,
        "The `onSubmit` prop is being called with one or more empty form fields"
      ).to.be.false;

      wrapper.find("#test-username").simulate("change", {
        target: { name: "username", id: "test-username", value: "johndoe" },
      });
      wrapper.find("#test-password").simulate("change", {
        target: { name: "password", id: "test-password", value: "" },
      });
      wrapper.find("form").simulate("submit", { preventDefault: noop });
      expect(
        spy.called,
        "The `onSubmit` prop is being called with one or more empty form fields"
      ).to.be.false;
    });
    
    it("should call the `onSubmit` callback prop when the form is being submitted", () => {
      const wrapper = shallow(<LoginForm onSubmit={spy} />);
      wrapper.find("#test-username").simulate("change", {
        target: { name: "username", id: "test-username", value: "johndoe" },
      });
      wrapper.find("#test-password").simulate("change", {
        target: {
          name: "password",
          id: "test-password",
          value: "supersecret",
        },
      });
      wrapper.find("form").simulate("submit", { preventDefault: spy });
      expect(spy.called, "The `onSubmit` prop is not being called").to.be.true;
    });
  });
});
